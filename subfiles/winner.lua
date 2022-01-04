temp={}

for y=205,605,100 do
  temp[y]={}
  for x=290,890,100 do
    temp[y][x]=0
  end
end


function win_check(dt)

  for keys,values in pairs(Many_tiles) do
    if values.status == 1 or values.status == 2 then
      temp[values.y][values.x]=values.status
    end
  end

  if Win() == true then
    gSounds['winner']:play()
    PlayState='GameOver'
  end

  if #Red_Coins==18 then
    if #Yellow_Coins==17 then
      if Win() == false then
        gSounds['winner']:play()
        PlayState = 'GameOver'
      end
    end
  end
end


function Win()
--  for x =290,890,100 do
  for y=205,305,100 do
    for x =290,890,100 do
      if ((temp[y][x] == 1 or temp[y][x] == 2 )   and temp[y][x] == temp[y+100][x]) and  (temp[y+100][x] == temp[y+200][x]) and (temp[y+200][x] == temp[y+300][x])  then
        return true
      end
    end
  end
  for y=205,605,100 do
    for x =290,590,100 do
      if ((temp[y][x] == 1 or temp[y][x] == 2 )   and
      temp[y][x] == temp[y][x+100]) and
      (temp[y][x+100] == temp[y][x+200]) and
      (temp[y][x+200] == temp[y][x+300])  then
        return true
      end
    end
  end
  for y=205,305,100 do
    for x =290,590,100 do
      if ((temp[y][x] == 1 or temp[y][x] == 2 )   and
      temp[y][x] == temp[y+100][x+100]) and
      (temp[y+100][x+100] == temp[y+200][x+200]) and
      (temp[y+200][x+200] == temp[y+300][x+300])  then
        return true
      end
    end
  end
  for y=605,505,-100 do
    for x =290,590,100 do
      if ((temp[y][x] == 1 or temp[y][x] == 2 )   and
      temp[y][x] == temp[y-100][x+100]) and
      (temp[y-100][x+100] == temp[y-200][x+200]) and
      (temp[y-200][x+200] == temp[y-300][x+300])  then
        return true
      end
    end
  end
  return false

  end

  function draw_winner()
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle('line', 290, 205, 705, 505)

    --Vertical lines of the grid
    love.graphics.line(390, 205, 390, 705)--line 1
    love.graphics.line(490, 205, 490, 705)--line 2
    love.graphics.line(590, 205, 590, 705)--line 3
    love.graphics.line(690, 205, 690, 705)--line 4
    love.graphics.line(790, 205, 790, 705)--line 5
    love.graphics.line(890, 205, 890, 705)--line 6

    --horizontal lines of the grid
    love.graphics.line(290, 305, 990, 305)--line 1
    love.graphics.line(290, 405, 990, 405)--line 1
    love.graphics.line(290, 505, 990, 505)--line 1
    love.graphics.line(290, 605, 990, 605)--line 1

    --Creating a sort of blur effect so that we know that the game isn't lost
    love.graphics.setColor(1,1,1,0.1)
    love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

    --Initializing the pause screen area
    love.graphics.setColor(180/255,180/255,180/255,0.8)
    love.graphics.rectangle('fill', WINDOW_WIDTH/2-400, WINDOW_HEIGHT/2-300, 800, 600)

    if PlayState == 'GameOver' then
      love.graphics.setColor(0,0,0,1)
      if Win() == true then
        if turn == 'player1' then
          love.graphics.print("Player 2 Wins!!" ,480,380)
          love.graphics.print("Press 'r' to reset",480,440)
          love.graphics.print("Press 'q' to quit",480,500)
        else
          love.graphics.print("Player 1 Wins!!",480,380)
          love.graphics.print("Press 'r' to reset",480,440)
          love.graphics.print("Press 'q' to quit",480,500)
        end

      else
        love.graphics.print("It's a DRAW!!",480,380)
        love.graphics.print("Press 'r' to reset",480,440)
        love.graphics.print("Press 'q' to quit",480,500)

      end
    end
    love.graphics.setColor(1,1,1,1)
  end
