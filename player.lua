local player = {}
local image

-- local idleDR = love.graphics.newQuad()

function player.load()
    image = love.graphics.newImage('middle.png')
end

function player.draw()
    love.graphics.draw(image)
end

return player