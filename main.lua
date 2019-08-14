floor_tile_width = 300
floor_tile_height = 220
floor_tile_depth = 80
floor_tile_count = 3
object_offset = 100
floor_tiles = {}
scale = 0.3
window_width, window_height = love.graphics.getDimensions()
window_width = window_width * (1 / scale)
window_height = window_height * (1 / scale)
stage = {}
objects = {}
stage_objects = {}

function love.load()
    landscape = love.graphics.newImage('landscape.png')
    width, height = landscape:getDimensions()
    rock_quad = love.graphics.newQuad(430, 30, 170, 190, width, height)
    bush_quad = love.graphics.newQuad(430, 370, 200, 170, width, height)
    tree_quad = love.graphics.newQuad(720, 40, 160, 690, width, height)
    rock = {quad = rock_quad, offset_x = -60, offset_y = 60}
    bush = {quad = bush_quad, offset_x = -45, offset_y = 30}
    tree = {quad = tree_quad, offset_x = -70, offset_y = 580}
    objects = {rock, bush, tree}
    for i = 1, floor_tile_count, 1 do
        floor_tiles[i] = love.graphics.newQuad(0, (i - 1) * floor_tile_height,
                                               floor_tile_width,
                                               floor_tile_height, width, height)
    end
    floor_tiles_weighted = {
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[2], floor_tiles[3]
    }
    pointer = {
        x = floor_tile_width / -2,
        y = (floor_tile_height / -2 - floor_tile_depth)
    }
    alternate = true
    while (pointer.x < window_width or pointer.y < window_height) do
        -- insert floor
        floor_tile_index = love.math.random(table.getn(floor_tiles_weighted))
        tile = floor_tiles_weighted[floor_tile_index]
        table.insert(stage, {x = pointer.x, y = pointer.y, tile = tile})

        -- insert object
        if tile == floor_tiles[3] then
            object = love.math.random() > 0.5 and bush or rock
            quad = object.quad
            _, _, object_width, object_height = quad:getViewport()
            table.insert(stage_objects, {
                x = pointer.x,
                y = pointer.y,
                offset_x = object.offset_x,
                offset_y = object.offset_y,
                tile = object.quad
            })
        end

        if tile == floor_tiles[2] then
            object = love.math.random() > 0.90 and tree or bush
            quad = object.quad
            _, _, object_width, object_height = quad:getViewport()
            table.insert(stage_objects, {
                x = pointer.x,
                y = pointer.y,
                offset_x = object.offset_x,
                offset_y = object.offset_y,
                tile = object.quad
            })
        end

        -- move pointer
        if pointer.x > window_width then
            pointer.x = alternate and 0 or floor_tile_width / -2
            pointer.y = pointer.y + floor_tile_depth
            alternate = not alternate
        else
            pointer.x = pointer.x + floor_tile_width
        end
    end
end

function gety(bh, th, oh)
    return bh - 70
end

function love.draw()
    love.graphics.scale(scale, scale)

    for i = 1, table.getn(stage), 1 do
        love.graphics.draw(landscape, stage[i].tile, stage[i].x, stage[i].y)
    end
    for i = 1, table.getn(stage_objects), 1 do
        love.graphics.draw(landscape, stage_objects[i].tile, stage_objects[i].x,
                           stage_objects[i].y, 0, 1, 1,
                           stage_objects[i].offset_x, stage_objects[i].offset_y)
    end
end
