--Declaring two tables for the motion of red and yellow coins respectively
--table for red coins
Red_Coins = {}
function Create_coins()
    coin = {}
    coin.x = mousex+50
    coin.y = mousey+50
    coin.radius= 50
    coin.motion = true
    return coin
end

--table for yellow coins
Yellow_Coins = {}
function Create_coins()
    coin = {}
    coin.x = mousex+50
    coin.y = mousey+50
    coin.radius= 50
    coin.motion = true
    return coin
end

-- the coins should fall only in their respective lanes and not in any other lane
--for that we must implement a function to control the traffic
function traffic(tablex)
    for keys, values in pairs(tablex) do --constrains on coins to keep them in place
        if values.x > 290 and values.x < 390 then --lane1
            values.x = 290
        elseif values.x > 390  and values.x < 490 then --lane2
            values.x = 390
        elseif values.x > 490 and values.x < 590 then --lane3
            values.x = 490
        elseif values.x > 590 and values.x < 690 then --lane4
            values.x = 590
        elseif values.x > 690 and values.x < 790 then --lane5
            values.x = 690
        elseif values.x > 790 and values.x < 890 then --lane6
            values.x = 790
        elseif values.x > 890 and values.x < 990 then --lane7
            values.x = 890
        end
    end
end

--a function to update the motion of the coins periodically
function coinupdate(dt)

  --motion of all red coins
    for keys,values in pairs(Red_Coins) do
        if values.motion == true then
        values.y = values.y + 680*dt
        end
        if values.y > 605 then
            gSounds['coindrop']:play()
            values.motion = false
            values.y = 605
        end
      end

    -- motion of all yellow coins
    for keys,values in pairs(Yellow_Coins) do
        if values.motion == true then
        values.y = values.y + 680*dt
        end
        if values.y > 605 then
            gSounds['coindrop']:play()
            values.motion = false
            values.y = 605
        end
    end
end

--Drawing the coins at their respective x and y
function Coins_draw()
  --drawing red coins
  for keys,values in pairs(Red_Coins) do
    love.graphics.draw(gTextures['player1'], values.x,values.y)
  end
--drawing yellow coins
  for keys,values in pairs(Yellow_Coins) do
    love.graphics.draw(gTextures['player2'], values.x,values.y)
  end
end

function coinstop(r,t) --- restricting coin in vertical direction
  for keys,values in pairs(r) do
      for i,j in pairs(t) do
          if values.x == j.x and values.y <= j.y + 100 and values.motion == false and j.motion == true then
              gSounds['coindrop']:play()
              j.motion = false
              j.y = values.y - 100
          end
      end
  end

end

function getLane(mousex)
  loc_lane = 0
  if GameState == 'inPlay' then
    if mousex >= 240 and mousex < 340 then
      loc_lane = 1
    elseif mousex >= 340  and mousex < 440 then
      loc_lane = 2
    elseif mousex >= 440 and mousex < 540 then
      loc_lane = 3
    elseif mousex >= 540 and mousex < 640 then
      loc_lane = 4
    elseif mousex >= 640 and mousex < 740 then
      loc_lane = 5
    elseif mousex >= 740 and mousex < 840 then
      loc_lane = 6
    elseif mousex >= 840 and mousex < 940 then
      loc_lane = 7
    end
  end
  return (loc_lane*100 + 190)
end


function upperrow(t)---not letting coins to be above frame
    for keys,values in pairs(t) do
        if values.y <= 105 and values.motion == false then
            table.remove(t,keys)
            if t == Red_Coins then
            turn = 'player1'
            else
                turn = 'player2'
            end
        end
    end
end
