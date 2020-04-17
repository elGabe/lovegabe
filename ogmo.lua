
local json = require "lovegabe.json"
local utils = require "lovegabe.utils"
local ogmo = {}

function ogmo.read_map(path, texture)
    local map = {}
    map.texture = texture
    local string = utils.read_file(path)
    map.data = json.decode(string)

    map.tiles = {}
    map.entities = {}

    -- Loop through all layers
    for l = #map.data.layers, 1, -1 do
        -- Get current layer
        local layer = map.data.layers[l]
        
        -- Check if this is an entity layer
        if layer.entities ~= nil then
            utils.add(map.entities, layer)
        
        -- Check if layer has data
        elseif layer.data2D ~= nil or layer.data ~= nil then
            utils.add(map.tiles, layer)
        end
    end


map.draw_map = function()
    -- Loop through the tiles to draw
    for l = #map.tiles, 1, -1 do
        -- Draw the respective tile quad
    end
end

    return map
end

return ogmo