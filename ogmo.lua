require "utils"
local json = require "json"

local ogmo = {}

function ogmo.read_map(path)
    local data = {}
    local string = read_file(path)
    data = json.decode(string)
end

return ogmo