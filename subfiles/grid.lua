Many_tiles = {}

--initializing all the individual grid elements
--making a 1D array
function Create_Grid()
  for row=0,4 do
    for column=1,7 do
      index = row*7 + column
      table.insert(Many_tiles,Create_Tiles(index,row,column))
    end
  end
end

--function to spawn the tiles
function Create_Tiles(var,row,column)
  gridtile = {}

  --defining the boxes and their characteristic
  gridtile.x = 190 + column*100
  gridtile.y = 205 + row*100
  gridtile.index = var

  --we will define the status of every tile
  -- 0 means that it is unoccupied
  --1 means it is occupied by player 1
  --2 means it is occupied by player 2
  gridtile.status = 0


  return gridtile
end

-- Code Block related to drawing the entire grid
function draw_grid()
  if GameState =='inPlay' then

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

    end
end

  --[[code block related to drawing the sperate tiles and their contents
function draw_gridtile()
  for keys,values in pairs(Many_tiles) do

      --setting the colors of red occupied tiles
    if values.status == 1 then
      love.graphics.draw(gTextures['player1'], values.x, values.y)

      --setting the colors of yellow occupying tiles
    elseif values.status == 2 then
      love.graphics.draw(gTextures['player2'], values.x, values.y)

      end
  end
end]]

function tilestatus() --status to tile according to coin
  for keys,values in pairs(Many_tiles) do
    for i,j in pairs(Red_Coins) do
      if values.x == j.x and j.y == values.y  and j.motion == false and values.status == 0 then
        values.status = 1
      end
    end
  end
  for keys,values in pairs(Many_tiles) do
    for i,j in pairs(Yellow_Coins) do
      if values.x == j.x and values.y == j.y and j.motion == false and values.status == 0 then
        values.status = 2
      end
    end
  end
end
