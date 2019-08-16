local player = require("player")
local map = require("map")
local scale = 0.3

function love.load()
    player.load()
    map.load(scale)
end

function love.draw()
    love.graphics.scale(scale, scale)
    map.draw()
    player.draw()
    
end
