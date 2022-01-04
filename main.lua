-- files required
require 'subfiles/constants'
require 'subfiles/grid'
require 'subfiles/pausescreen'
require 'subfiles/home'
require 'subfiles/winner'
require 'subfiles/reset'
require 'coins'
require 'instructions'
require 'subfiles/Settings'

function love.load()
  love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
  love.window.setTitle("CONNECT 4",'fullscreen')

  --creating a global table for all the graphics
  gTextures = {
    ['player2'] = love.graphics.newImage('media/player12.png'),
    ['player1'] = love.graphics.newImage('media/player11.png'),
    ['logo'] = love.graphics.newImage('media/name.png'),
    ['turn1'] = love.graphics.newImage('media/turn1.png'),
    ['turn2'] = love.graphics.newImage('media/turn2.png'),
    ['volumeon'] = love.graphics.newImage('media/vol_on.png'),
    ['volumeoff'] = love.graphics.newImage('media/vol_off.png'),
    ['playbutton'] = love.graphics.newImage('media/playbutton.png'),
    ['settings'] = love.graphics.newImage('media/settings.png'),
    ['line1'] = love.graphics.newImage('media/textline1.png'),
    ['line2'] = love.graphics.newImage('media/textline2.png'),
    ['line3'] = love.graphics.newImage('media/textline3.png'),
    ['gdutopia'] = love.graphics.newImage('media/Gamedev_logo.png')
  }

  background = love.graphics.newImage('media/bg.jpeg')

  gSounds = {
    ['music'] = love.audio.newSource('media/bg2.wav','static'),
    ['mouseclick'] = love.audio.newSource('media/mouseclick.wav','static'),
    ['coindrop'] = love.audio.newSource('media/coindrop.wav','static'),
    ['winner'] = love.audio.newSource('media/winner_sound.wav','static'),
    ['select'] = love.audio.newSource('media/select_sound.wav','static')
  }
  Create_Grid()

  gSounds['music']:play()
  gSounds['music']:setLooping(true)
end


function love.update(dt)

  --setting the range for coin movement
  cursor = love.mouse.getX()-50
  if(cursor<290) then
    mousex = 290
  elseif(cursor>890) then
    mousex = 890
  else
    mousex = cursor
  end
  mousey = 90

  --getting the lane that the coin is in
  lane = getLane(mousex)

  coinupdate(dt) --updating the position of the coin

  --stopping the movement of all coins once they have collided
  coinstop(Red_Coins,Yellow_Coins)
  coinstop(Yellow_Coins,Red_Coins)
  coinstop(Red_Coins,Red_Coins)
  coinstop(Yellow_Coins,Yellow_Coins)

  --updating the status of the tile coin is in
  tilestatus()

  --checking if uppermost row is filled
  upperrow(Red_Coins)
  upperrow(Yellow_Coins)
  if PlayState == 'GameStarted' then
    win_check(dt)
  end
end


function love.draw()
  love.graphics.draw(background,0,0,0,love.graphics.getWidth()/background:getWidth(), love.graphics.getHeight()/background:getHeight())
  love.graphics.draw(gTextures['gdutopia'],1100,50,0,130/gTextures['gdutopia']:getWidth(), 150/gTextures['gdutopia']:getHeight())

  if GameState == 'home' then
    draw_HomePage()
    --prompting the escape to quit
    love.graphics.print("Press 'esc' to quit game", 1000, 840)

  elseif GameState == 'Settings' then
    draw_Settings()

  else
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['logo'], WINDOW_WIDTH/2 - 215, 50,0,2.2,2.2)
  end

  --screen during playstate

  if(GameState == 'inPlay') then
    -- drawing the coins then drawing the grid
    Coins_draw()
    draw_grid()
    if PlayState == 'GameStarted' then
      if turn =='player1' then
        love.graphics.draw(gTextures['turn1'], WINDOW_WIDTH/2 - 120, 750)
        love.graphics.draw(gTextures['player1'],lane,mousey)

      elseif turn =='player2' then
        love.graphics.draw(gTextures['turn2'], WINDOW_WIDTH/2 - 120, 750)
        love.graphics.draw(gTextures['player2'],lane,mousey)

      end

    elseif PlayState == 'GameOver' then
      draw_winner()
    end


  elseif(GameState == 'pause') then
    Coins_draw()
    Draw_PauseScreen()
  end

  --instruction()
end


--Here we define the mousepressed function for different states
--[[1. On the home screen we will implement the mousepressed to navigate between the instructions and the start game states
    2. Once in the playstate we will use the mouse pressed function to switch between player moves and execute the coin drop
    3. we will also use the mousepress to navigate between pause and play states ]]

function love.mousepressed(x,y,button,isTouch)
  gSounds['mouseclick']:play()
--Home screen to game screen
  if GameState == 'home' then
      if button == 1 then
        if(x>570 and x<715 and y>560 and y<705) then
          GameState = 'inPlay'
          PlayState = 'GameStarted'
        elseif(x>50 and x<110 and y>50 and y<110) then
          GameState = 'Settings'
        end
      end

--game screen inPlay mechanics
elseif(GameState == 'inPlay' and PlayState == 'GameStarted') then

  if PlayState == 'GameStarted' then

          --switching between the two players on the click
      if (button == 1) then
        gSounds['mouseclick']:play()
        if(turn=='player1') then

          turn = 'player2'
          table.insert(Red_Coins,Create_coins()) --inserting red coins
          traffic(Red_Coins) -- constrains

        elseif (turn=='player2') then
          turn = 'player1'
          table.insert(Yellow_Coins,Create_coins()) -- inserting yellow coins
          traffic(Yellow_Coins) -- constrains

        end
      end
    end

  elseif(GameState == 'pause' or GameState == 'Settings') then
    if (button == 1) then
      if(x>290 and x<360 and love.mouse.getY()>200 and love.mouse.getY()<270) then
        gSounds['select']:play()
        if sound == 'on' then
          gSounds['music']:pause()
          sound = 'off'
        else
          gSounds['music']:play()
          sound = 'on'
        end
      end
    end
  end
end

--[[we will implement keypressed functions to toggle between pause and play states and also to quit the game]]
function love.keypressed(key)
  --escape key functionality
  if key == 'escape' then
    if GameState == 'pause' then
      reset_ragequit()
      GameState = 'home'
      PlayState = 'null'
      turn = 'player1'
    elseif (GameState == 'inPlay' and PlayState == 'GameStarted') then
      GameState = 'pause'
    elseif GameState == 'Settings' then
      GameState = 'home'
    elseif GameState == 'home' then
      love.event.quit()
    end

  --space key functionality
  elseif (key == 'space') then
    if(GameState=='inPlay' and PlayState == 'GameStarted') then
      GameState ='pause'
    elseif GameState=='pause' then
      GameState='inPlay'
    end

  elseif (key == 'r') then
    if(GameState == 'inPlay') then
      if(PlayState == 'GameOver') then
        reset_ingame()
        PlayState = 'GameStarted'
        turn = 'player1'
      end
    end

  elseif (key == 'q') then
    if(GameState == 'inPlay') then
      if(PlayState == 'GameOver') then
        reset_ragequit()
        PlayState = 'null'
        turn = 'player1'
        GameState = 'home'
      end
    end
  end
end
