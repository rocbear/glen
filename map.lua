local map = {}
local image
local tileWidth = 300
local tileImageHeight = 220
local tileDepth = 60
local tileHeight = tileImageHeight - tileDepth
local tileVariants = 3
local tiles = {}
local stage = {}
local objects = {}
local stageObjects = {}

local function nextTileY(index) return (index - 1) * tileImageHeight end

local tileWeightRatio = 5

function map.load(scale)
    image = love.graphics.newImage('landscape.png')
    imageWidth, imageHeight = image:getDimensions()
    windowWidth, windowHeight = love.graphics.getDimensions()
    windowWidth = windowWidth * (1 / scale)
    windowHeight = windowHeight * (1 / scale)
    for i = 1, tileVariants, 1 do
        for n = 1, tileVariants * tileWeightRatio - (i * tileWeightRatio - 1), 1 do
            table.insert(tiles,
                         love.graphics.newQuad(0, nextTileY(i), tileWidth,
                                               tileImageHeight, imageWidth,
                                               imageHeight))
        end
    end

    local rockQuad = love.graphics.newQuad(430, 30, 170, 190, imageWidth,
                                           imageHeight)
    local bushQuad = love.graphics.newQuad(430, 370, 200, 170, imageWidth,
                                           imageHeight)
    local treeQuad = love.graphics.newQuad(720, 40, 160, 690, imageWidth,
                                           imageHeight)
    local rock = {quad = rockQuad, offsetX = -60, offsetY = 60}
    local bush = {quad = bushQuad, offsetX = -45, offsetY = 30}
    local tree = {quad = treeQuad, offsetX = -70, offsetY = 580}
    objects = {rock, bush, tree}

    local pointer = {x = tileWidth / -2, y = -90}
    local alternate = true
    while (pointer.x < windowWidth or pointer.y < windowHeight) do
        -- insert floor
        local floorTileIndex = love.math.random(table.getn(tiles))
        local tile = tiles[floorTileIndex]
        local points = {
            pointer.x, pointer.y + tileHeight / 2, pointer.x + tileWidth / 2,
            pointer.y, pointer.x + tileWidth, pointer.y + tileHeight / 2,
            pointer.x + tileWidth / 2, pointer.y + tileHeight
        }
        local shape = love.physics.newPolygonShape(points)
        table.insert(stage, {
            x = pointer.x,
            y = pointer.y,
            tile = tile,
            points = points,
            shape = shape
        })

        -- insert object
        if love.math.random() > 0.94 then
            object = objects[love.math.random(table.getn(objects))]
            quad = object.quad
            table.insert(stageObjects, {
                x = pointer.x,
                y = pointer.y,
                offsetX = object.offsetX,
                offsetY = object.offsetY,
                tile = object.quad
            })
        end

        -- move pointer
        if pointer.x > windowWidth then
            pointer.x = alternate and 0 or tileWidth / -2
            pointer.y = pointer.y + tileHeight / 2
            alternate = not alternate
        else
            pointer.x = pointer.x + tileWidth
        end
    end
end

function map.update(dt, scale)
    x, y = love.mouse.getPosition()
    for i = 1, table.getn(stage), 1 do
        stage[i].highlight = stage[i].shape:testPoint(0, 0, 0, x * scale,
                                                      y * scale)
    end
end

function map.draw()
    for i = 1, table.getn(stage), 1 do
        love.graphics.draw(image, stage[i].tile, stage[i].x, stage[i].y)
    end
end

function map.drawObjects()
    for i = 1, table.getn(stageObjects), 1 do
        love.graphics.draw(image, stageObjects[i].tile, stageObjects[i].x,
                           stageObjects[i].y, 0, 1, 1, stageObjects[i].offsetX,
                           stageObjects[i].offsetY)
    end
    local lineWidth = love.graphics.getLineWidth()
    love.graphics.setLineWidth(10)
    love.graphics.setColor(0.5, 1.0, 0.5, 0.9)
    for i = 1, table.getn(stage), 1 do
        if stage[i].highlight then
            love.graphics.polygon('line', stage[i].points)
        end
    end
    love.graphics.setColor(255, 255, 255, 1.0)
    love.graphics.setLineWidth(lineWidth)
end

return map
