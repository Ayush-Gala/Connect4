function reset_ingame()
  for key,value in pairs(Many_tiles) do
    value.status = 0
    temp[value.y][value.x]=value.status
  end

  while #Yellow_Coins ~= 0 do
    rawset(Yellow_Coins, #Yellow_Coins, nil)
  end

  while #Red_Coins ~= 0 do
    rawset(Red_Coins, #Red_Coins, nil)
  end
end

function reset_ragequit()

  for key,value in pairs(Many_tiles) do
    value.status = 0
    temp[value.y][value.x]=value.status
  end

  while #Yellow_Coins ~= 0 do
    rawset(Yellow_Coins, #Yellow_Coins, nil)
  end

  while #Red_Coins ~= 0 do
    rawset(Red_Coins, #Red_Coins, nil)
  end



end
