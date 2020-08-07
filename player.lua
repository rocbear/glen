local newAnimation = require("animation")

local player = {}
local image

local idleDRQuad
local idleULQuad
local idleDLQuad
local idleURQuad
local walkAnimations = {}
local animation = {}

function player.load()
    image = love.graphics.newImage('middle.png')
    imageWidth, imageHeight = image:getDimensions()
    player.position = {x = 0, y = 0}
    idleDRQuad = love.graphics.newQuad(140, 80, 160, 350, imageWidth,
                                       imageHeight)
    idleULQuad = love.graphics.newQuad(1350, 90, 160, 350, imageWidth,
                                       imageHeight)
    idleDLQuad = love.graphics.newQuad(140, 830, 160, 350, imageWidth,
                                       imageHeight)
    idleURQuad = love.graphics.newQuad(910, 840, 160, 350, imageWidth,
                                       imageHeight)
    walkAnimations.DR = newAnimation(0.5, {
        love.graphics.newQuad(140, 460, 160, 340, imageWidth, imageHeight),
        love.graphics.newQuad(390, 450, 160, 360, imageWidth, imageHeight),
        love.graphics.newQuad(620, 460, 170, 350, imageWidth, imageHeight)
    })
    animation = walkAnimations.DR

end

function player.update(dt)
    player.position.x = player.position.x + 4
    player.position.y = player.position.y + 4
    animation.update(dt)
end

function player.draw()
    -- love.graphics.new
    -- love.graphics.drawLayer(image, 1, idleDLQuad, 100, 100)
    love.graphics.draw(image, idleDRQuad, player.position.x,
                       player.position.y)
end

return player
