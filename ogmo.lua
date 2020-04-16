
local json = require "lovegabe.json"
local utils = require "lovegabe.utils"
local ogmo = {}

function ogmo.read_map(path)
    local map = {}
    local string = utils.read_file(path)
    map = json.decode(string)
    return map
end

return ogmo