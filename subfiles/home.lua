function draw_HomePage()
  --drawing the logo
  love.graphics.draw(gTextures['logo'], WINDOW_WIDTH/2 - 300, 100,0,3,3)

  --drawing the motto
  love.graphics.draw(gTextures['line1'],150,250)
  love.graphics.draw(gTextures['line2'],525,250)
  love.graphics.draw(gTextures['line3'],862,250)

  --drawing the settings
  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.draw(gTextures["settings"], 50, 50, 0, 0.25, 0.25)

  --drawing the playbutton
  love.graphics.draw(gTextures["playbutton"], WINDOW_WIDTH/2-70, 560, 0, 0.3, 0.3)


end
