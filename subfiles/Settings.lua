function draw_Settings()

  draw_HomePage()

  --Creating a sort of blur effect so that we know that the game isn't lost
  love.graphics.setColor(1,1,1,0.1)
  love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

  --Initializing the setting screen area
  love.graphics.setColor(180/255,180/255,180/255,0.8)
  love.graphics.rectangle('fill', WINDOW_WIDTH/2-400, WINDOW_HEIGHT/2-300, 800, 600)
  love.graphics.setColor(0,0,0,1)

  -- displaying the instructions
  love.graphics.print('\n\nINSTRUCTIONS: \n1)Red always starts first. Left click to place coins.\n2)Players will take alternate turns dropping discs, and only one disc can be\n    dropped in each turn.\n3)The game ends when all tiles are filled.\n4)The player having maximum number of 4 consecutive discs horizontally,\n    vertically or diagonally will win.\n\n\nNOTE:\n1)You can turn the music off by clicking on the volume icon.\n2)You can pause the game by pressing "Spacebar" and exit mid-game using\nthe "esc" button on your keyboard.\n\n\n                                                       HAVE FUN!\n\n\nPress "esc" to return to Home Screen',WINDOW_WIDTH/2-370,WINDOW_HEIGHT/2-200)


  love.graphics.setColor(1,1,1,1)
  -- displaying the volume settings
  if sound == 'on' then
    love.graphics.draw(gTextures['volumeon'],WINDOW_WIDTH/2-350, WINDOW_HEIGHT/2-250,0,70/gTextures['volumeon']:getWidth(),70/gTextures['volumeon']:getHeight())
  elseif sound == 'off' then
    love.graphics.draw(gTextures['volumeoff'],WINDOW_WIDTH/2-350, WINDOW_HEIGHT/2-250,0,70/gTextures['volumeoff']:getWidth(),70/gTextures['volumeoff']:getHeight())
  end

end
