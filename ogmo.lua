
local json = require "lovegabe.json"
local ogmo = {}

add = table.insert

-- Reads an ogmo json file and takes in a texture to assign to the level
function ogmo.read_map(path, texture)
    local map = {}
    map.texture = texture
    local string = love.filesystem.read(path)
    map.data = json.decode(string)

    map.tiles = {}
    map.entities = {}
    map.width = map.data.width
    map.height = map.data.height

    -- Loop through all layers
    for l = #map.data.layers, 1, -1 do
        -- Get current layer
        local layer = map.data.layers[l]
        
        -- Check if this is an entity layer
        if layer.entities ~= nil then
            add(map.entities, layer)
        end
        
        -- Check if layer has data
        if layer.data ~= nil then
            add(map.tiles, layer)
        end

        if (layer.data2D ~= nil) then
            --[TODO] Unpack data2D into 1D array and run through same process
        end
    end

    -- Information to split the texture
    local cell_width = map.data.layers[1].gridCellWidth
    local cell_height = map.data.layers[1].gridCellHeight
    local grid_width = map.data.layers[1].gridCellsX
    local grid_height = map.data.layers[1].gridCellsY
    local texture_width = map.texture:getWidth()
    local texture_height = map.texture:getHeight()

    map.subimages = {}

    -- locals instead of globals for performance
    local love_draw = love.graphics.draw
    local love_quad = love.graphics.newQuad

    -- Splitting texture into individual tile images
    for uvy = 0, (texture_height / cell_height) - 1 do
        for uvx = 0, (texture_width / cell_width) - 1 do
            local quad = love_quad(uvx * cell_width, uvy * cell_height, cell_width, cell_height, map.texture:getDimensions())
            add(map.subimages, quad)
        end
    end

function map:draw()

    -- Loop through the tiles to draw
    for l = #map.tiles, 1, -1 do
        local layer = map.tiles[l]

        for y = 0, grid_height-1 do
            for x = 0, grid_width-1 do
                local tile = layer.data[(y * grid_width + x) + 1]
                local xx = cell_width * x
                local yy = cell_height * y

                if (tile ~= -1) then
                    local lovedraw = love.graphics.draw
                    love_draw(map.texture, map.subimages[tile+1], xx, yy)
                end
            end
        end
    end

end

    return map
end

return ogmo