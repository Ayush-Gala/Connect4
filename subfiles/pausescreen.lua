function Draw_PauseScreen()
  --We will draw the existing grid in the background so that the transition looks smooth
  if GameState == 'pause' then
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

    --text that will go on screen
    love.graphics.setColor(0,0,0,1)
    love.graphics.setFont(love.graphics.newFont(100))
    love.graphics.print("GAME PAUSED", WINDOW_WIDTH/2-350,WINDOW_HEIGHT/2-100)
    love.graphics.setFont(love.graphics.newFont(50))
    love.graphics.print("\nPress 'space' to resume\nPress 'esc' to quit to Home", WINDOW_WIDTH/2-350,WINDOW_HEIGHT/2-50)
    love.graphics.setColor(1,1,1,1)

    -- displaying the volume settings
    if sound == 'on' then
      love.graphics.draw(gTextures['volumeon'],WINDOW_WIDTH/2-350, WINDOW_HEIGHT/2-250,0,70/gTextures['volumeon']:getWidth(),70/gTextures['volumeon']:getHeight())

    elseif sound == 'off' then
      love.graphics.draw(gTextures['volumeoff'],WINDOW_WIDTH/2-350, WINDOW_HEIGHT/2-250,0,70/gTextures['volumeoff']:getWidth(),70/gTextures['volumeoff']:getHeight())

    end
  end
end
