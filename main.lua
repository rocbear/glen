local player = require("player")
local map = require("map")
local scale = 0.2

function love.load()
    player.load()
    map.load(scale)
end

function love.update(dt)
    player.update(dt)
    map.update(dt, 1 / scale)
end

function love.draw()
    love.graphics.scale(scale, scale)
    map.draw()
    map.drawObjects()
    player.draw()
end
