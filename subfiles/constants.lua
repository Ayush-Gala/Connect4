--defining some global constants in this file so that main file doesn't get clogged up

--defining the screen resolution
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 900

--initializing GameState
--[[ List of GameStates
1. Home
2. Instructions
3. Settings
4. inPlay
5. pause
]]
--at the beginning the GameState will be home
GameState = 'home'

--initializing Playstate. Contrary to Gamestate, playstate checks the
--conditions of the game
--[[
1.GameStarted
2.GameOver
3.null
]]
PlayState = 'null'
--initializing player turn
turn = 'player1'

--status of the game sounds
sound = 'on'
