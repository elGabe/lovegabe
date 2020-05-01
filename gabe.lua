-- Utilities for love2D programming
-- By Gabe <3

local gabe = {}

-- V1

-----------------------------------------
-- Tables
-----------------------------------------

-- Adds an element (e) into a table (t)
function gabe.add(t, e)
    table.insert(t, e)
end

-- Deletes an element (e) from a table (t)
function gabe.del(t, e)
    for i = #t, 1, -1 do
        local _e = t[i]
        if e == _e then table.remove(t, i) end
    end
end

-- Approach (from GameMaker)
function gabe.approach(start, target, shift)
    if start < target then
        return math.min(start + shift, target)
    else
        return math.max(start - shift, target)
    end
end

-- Lengthdir X (from GameMaker)
function gabe.lengthdir_x(len, dir)
    return math.cos(dir) * len
end

-- Lengthdir Y (from GameMaker)
function gabe.lengthdir_y(len, dir)
    return math.sin(dir) * len
end

-- Lengthdir (x & y)
function gabe.lengthdir(len, dir)
    return math.cos(dir) * len, math.sin(dir) * len
end

----------------------------------------
-- Color Conversion (Love2D)
----------------------------------------

-- Maps RGB color from 0-255 to 0-1
-- Assumes 100% opacity
function gabe.rgb(r, g, b)
    local r1, g1, b1 = r/255, g/255, b/255
    return {r1, g1, b1, 1}
end

-- Maps RGB color from 0-255 to 0-1
function gabe.rgba(r, g, b, a)
    local r1, g1, b1, a1 = r/255, g/255, b/255, a/255
    return {r1, g1, b1, a1}
end

-- Converts HSL color to RGB
function gabe.hsl(h, s, l, a)
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

function gabe.read_file(path)
    local file = io.open(path, "rb")
    if not file then 
        print("Could not find file at "..path)
        return nil
    end
    local content = file:read "*a"
    file:close()
    return content
end

----------------------------------------
-- Sprite Sheets
----------------------------------------

-- Creates a new sprite
function gabe.new_sprite(texture, x, y, w, h)
    local sprite = {}
    if texture == nil then error("No 'texture' was given to sprite") return end
    sprite.texture = texture
    sprite.x = x or 0
    sprite.y = y or 0
    sprite.width = w or 8
    sprite.height = h or 8

    sprite.frames = {}
    sprite.frame = 1

sprite.new_frame = function(sprite, uvx, uvy)
    local frame = love.graphics.newQuad(uvx, uvy, sprite.width, sprite.height, sprite.texture:getDimensions())
    gabe.add(sprite.frames, frame)
end

sprite.draw = function()
    if #sprite.frames > 0 then
        love.graphics.draw(sprite.texture, sprite.frames[sprite.frame], sprite.x, sprite.y)
    else
        love.graphics.draw(sprite.texture, sprite.x, sprite.y)
    end
end

    return sprite
end

----------------------------------------
-- Collision
----------------------------------------

function gabe.make_AABB(x, y, w, h)
    local aabb = {}
    aabb.x1 = x
    aabb.y1 = y
    aabb.w = w
    aabb.h = h
    aabb.x2 = aabb.x1 + aabb.w
    aabb.y2 = aabb.y1 + aabb.h

function aabb:update(x, y)
    aabb.x1 = x
    aabb.y1 = y
    aabb.x2 = aabb.x1 + aabb.w
    aabb.y2 = aabb.y1 + aabb.h
end

function aabb:draw(color)
    color = color or gabe.rgb(0, 255, 0)
    love.graphics.setColor(color)
    love.graphics.rectangle("line", aabb.x1, aabb.y1, aabb.w, aabb.h)
end

    return aabb
end

function gabe.overlap(box1, box2)
    return not (box1.x1 > box2.x2 
                or box1.y1 > box2.y2 
                or box1.x2 < box2.x1 
                or box1.y2 < box2.y1)
end

----------------------------------------
-- Timers
----------------------------------------

local TIMERS = {}

function gabe.every_n_seconds(time, callback)
    local timer = {}
    timer.time = time
    timer.current = time
    timer.callback = callback

function timer:update(dt)
    timer.current = timer.current - dt

    if timer.current < 0 then
        timer.callback()
        timer.current = timer.time
    end
end

function timer:stop()
    gabe.del(TIMERS, timer)
end
    gabe.add(TIMERS, timer)
    return timer
end

return gabe