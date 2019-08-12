floor_tile_width = 300
floor_tile_height = 220
floor_tile_depth = 30
floor_tile_count = 3
floor_tiles = {}
scale = 0.3
window_width, window_height = love.graphics.getDimensions()
window_width = window_width * (1 / scale)
window_height = window_height * (1 / scale)
stage = {}

function love.load()
    landscape = love.graphics.newImage('landscape.png')
    width, height = landscape:getDimensions()
    for i = 1, floor_tile_count, 1 do
        print(i)
        floor_tiles[i] =
            love.graphics.newQuad(
            0,
            (i - 1) * floor_tile_height,
            floor_tile_width,
            floor_tile_height,
            width,
            height
        )
    end
    floor_tiles_weighted = {
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1], floor_tiles[1],
        floor_tiles[2],
        floor_tiles[3]
    }
    pointer = {
        x = floor_tile_width / -2,
        y = (floor_tile_height / -2 - floor_tile_depth)
    }
    alternate = true
    while ( pointer.x < window_width or pointer.y < window_height) do
        table.insert(stage, {
            x = pointer.x,
            y = pointer.y,
            tile = floor_tiles_weighted[love.math.random(table.getn(floor_tiles_weighted))]
        })
        if pointer.x > window_width then
            pointer.x = alternate and 0 or floor_tile_width / -2
            pointer.y = (pointer.y + floor_tile_height / 2) - floor_tile_depth
            alternate = not alternate
        else
            pointer.x = pointer.x + floor_tile_width
        end
    end
end

function love.draw()
    love.graphics.scale(scale, scale)
    love.graphics.draw(landscape, stage[1].tile, stage[1].x, stage[1].y)
    for i = 1, table.getn(stage), 1 do
        love.graphics.draw(landscape, stage[i].tile, stage[i].x, stage[i].y)
    end
end
