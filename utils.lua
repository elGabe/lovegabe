-- Utilities for love2D programming
-- By Gabe <3

-- V1

-----------------------------------------
-- Tables
-----------------------------------------

-- Adds an element (e) into a table (t)
function add(t, e)
    table.insert(t, e)
end

-- Deletes an element (e) from a table (t)
function del(t, e)
    table.remove(t, e)
end

----------------------------------------
-- Math (from lua-users.org: http://lua-users.org/wiki/MathLibraryTutorial)
----------------------------------------

-- Absolute value
function abs(n)
    return math.abs(n)
end

-- Arc Cosine
function acos(n)
    return math.acos(n)
end

-- Arc Sine
function asin(n)
    return math.asin(n)
end

-- Arc Tangent
function atan(n)
    return math.atan(n)
end

-- Ceil
function ceil(n)
    return math.ceil(n)
end

-- Floor
function floor(n)
    return math.floor(n)
end

-- Cosine
function cos(n)
    return math.cos(n)
end

-- Sine
function sin(n)
    return math.sin(n)
end

-- Tangent
function tan(n)
    return math.tan(n)
end

-- Radians to Degrees
function rad2deg(n)
    return math.deg(n)
end

-- Degrees to Radians
function deg2rad(n)
    return math.rad(n)
end

-- Min [TODO: Multiple argument support]
-- function min(n, x, ...)
--     if arg ~= nil then 
--         print(arg[1])
--         return math.min(n, x, unpack(arg)) 
--     end
--     return math.min(n, x)
-- end

-- -- Max [TODO: Multiple argument support]
-- function max(n, x, ...)
--     if #arg~=0 then return math.max(n, x, unpack(arg)) end
--     return math.max(n, x)
-- end

-- Square Root
function sqr(n)
    return math.sqrt(n)
end

-- Random [TODO: Multiple argument support]
-- function rand(...)
--     return math.random(unpack(arg))
-- end

-- Random Seed
function seed(n)
    return math.randomseed(n)
end

-- Pi
PI = math.pi

-- Approach (from GameMaker)
function approach(start, target, shift)
    if start < target then
        return math.min(start + shift, target)
    else
        return math.max(start - shift, target)
    end
end

-- Lengthdir X (from GameMaker)
function lengthdir_x(len, dir)
    return math.cos(dir) * len
end

-- Lengthdir Y (from GameMaker)
function lengthdir_y(len, dir)
    return math.sin(dir) * len
end

-- Lengthdir (x & y)
function lengthdir(len, dir)
    return math.cos(dir) * len, math.sin(dir) * len
end

----------------------------------------
-- Color Conversion (Love2D)
----------------------------------------

-- Maps RGB color from 0-255 to 0-1
-- Assumes 100% opacity
function rgb(r, g, b)
    local r1, g1, b1 = r/255, g/255, b/255
    return {r1, g1, b1, 1}
end

-- Maps RGB color from 0-255 to 0-1
function rgba(r, g, b, a)
    local r1, g1, b1, a1 = r/255, g/255, b/255, a/255
    return {r1, g1, b1, a1}
end

-- Converts HSL color to RGB
function hsl(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h/256*6, s/255, l/255
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m)*255,(g+m)*255,(b+m)*255,a
end

----------------------------------------
-- Reading Files
----------------------------------------

function read_file(path)
    local file = io.open(path, "rb")
    if not file then 
        print("Could not find file at "..path)
        return nil
    end
    local content = file:read "*a"
    file:close()
    return content
end