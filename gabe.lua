-- Utilities for love2D programming
-- By Gabe <3
--
-- Copyright (c) 2020 elGabe
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--


local gabe = {}

-----------------------------------------
-- Tables
-----------------------------------------

-- Alias for lua's 'table.insert' function
gabe.add = table.insert

-- Deletes an element (e) from a table (t)
function gabe.del(t, e)
    for i = #t, 1, -1 do
        local _e = t[i]
        if e == _e then table.remove(t, i) end
    end
end

-----------------------------------------
-- Maths
-----------------------------------------

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

-- Linear interpolation
function gabe.lerp(a, b, t)
    return a + t * (b - a)
end

-- Get the sign of a numebr
function gabe.sign(n)
    return n > 0 and 1 or (n == 0 and 0 or -1)
end

-- Convert degrees to radians
function gabe.deg2rad(degrees)
    return degrees * (math.pi / 180)
end

-- Convert radians to degrees
function gabe.rad2deg(radians)
    return radians * (180 / math.pi)
end

-- Clamp a number between two values
function gabe.clamp(value, min, max)
    if min > max then min, max = max, min end -- swap if boundaries supplied the wrong way
    return math.max(min, math.min(max, value))
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
-- Sprite Sheets
----------------------------------------

-- Creates a new sprite
function gabe.make_sprite(texture, w, h, frames)
    local sprite = {}
    if texture == nil then error("No 'texture' was given to sprite") return end
    sprite.texture = texture
    sprite.width = w or 8
    sprite.height = h or 8

    sprite.xscale = 1
    sprite.yscale = 1

    sprite.origin = {
        x = 0.5,
        y=0.5
    }

    sprite.frames = {}
    sprite.frame_index = 1

    -- Number of frames must be at least 1
    local _frames = frames or 1
    -- Stay safe and force it to be a possitive, non-zero value
    if (_frames <= 0) then _frames = 1 end

    if (_frames > 1) then
        -- Splits the image into frame cells
        local cells_x = sprite.texture:getWidth() / sprite.width
        local cells_y = sprite.texture:getHeight() / sprite.height

        for uv_x = 0, cells_x-1 do
            for uv_y = 0, cells_y-1 do
                local frame = love.graphics.newQuad(uv_x * sprite.width, uv_y * sprite.height, sprite.width, sprite.height, sprite.texture:getDimensions())
                gabe.add(sprite.frames, frame)
            end
        end
    end

function sprite:make_frame(uvx, uvy)
    local frame = love.graphics.newQuad(uvx * sprite.width, uvy * sprite.height, sprite.width, sprite.height, sprite.texture:getDimensions())
    gabe.add(sprite.frames, frame)
end

-- [TODO: Figure out animation!]
function sprite:draw(x, y, angle)
    if #sprite.frames > 0 then
        love.graphics.draw(sprite.texture, sprite.frames[sprite.frame_index], x, y, angle, sprite.xscale, sprite.yscale, sprite.origin.x * sprite.width, sprite.origin.y * sprite.height)
    else
        love.graphics.draw(sprite.texture, x, y, angle, sprite.xscale, sprite.yscale, sprite.origin.x * sprite.width, sprite.origin.y * sprite.height)
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
    love.graphics.setColor(1, 1, 1, 1)
end

    return aabb
end

function gabe.overlap(box1, box2, dx, dy)
    local dx, dy = dx or 0, dy or 0
    return not (box1.x1 + dx > box2.x2
                or box1.y1 + dy > box2.y2
                or box1.x2 + dx < box2.x1
                or box1.y2 + dy < box2.y1)
end

-- UPDATE THIS TO CHECK BETWEEN 2 TABLES AS WELL!
function gabe.check_collisions(objects_1, objects_2)
    
    if (type(objects_1) == "table") then
        -- For each object
        for i = #objects_1, 1, -1 do
            for j = #objects_2, 1, -1 do
                local obj_1 = objects_1[i]
                local obj_2 = objects_2[j]
                if (gabe.overlap(obj_1.bbox, obj_2.bbox)) then
                    return obj_1, obj_2
                end
            end
        end
    end
    
    -- This happens if 'objects_1' is actually just a single object
    for i = #objects_2, 1, -1 do
        local object = objects_2[i]
        if (gabe.overlap(objects_1.bbox, object.bbox)) then
            return object
        end
    end
end

----------------------------------------
-- Timers
----------------------------------------

local TIMERS = {}

function gabe.clear_timers()
    TIMERS = {}
end

function gabe.update_timers(dt)
    for i = #TIMERS, 1, -1 do

        TIMERS[i]:update(dt)
    end
end

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

function gabe.wait_n_seconds(time, callback)
    local timer = {}
    timer.time = time
    timer.current = time
    timer.callback = callback

function timer:update(dt)
    timer.current = timer.current - dt

    if timer.current < 0 then
        timer.callback()
        gabe.del(TIMERS, timer)
    end
end

function timer:stop()
    gabe.del(TIMERS, timer)
end
    gabe.add(TIMERS, timer)
    return timer
end


----------------------------------------
-- Virtual Screens
----------------------------------------

gabe.DEFAULT_WINDOW_SETTINGS = {
    fullscreen = false,
    fullscreentype = "desktop",
    vsync = false,
    msaa = 0,
    resizable = true
}

gabe.DEFAULT_WINDOW = {
    128,                             -- Pixel Width
    128,                             -- Pixel Height
    4,                               -- Window Scale
    gabe.DEFAULT_WINDOW_SETTINGS,    -- Settings
    gabe.rgb(30, 30, 30)
}

gabe.DEFAULT_CANVAS = {}

function gabe.make_window(width, height, scale, settings, clear_color)
    scale = scale or 1
    settings = settings or gabe.DEFAULT_WINDOW_SETTINGS
    clear_color = clear_color or gabe.rgb(30, 30, 30)
    local window = {}
    window.width = width * scale
    window.height = height * scale
    window.scale = scale
    window.settings = settings
    window.clear_color = clear_color
    love.window.setMode(window.width, window.height, window.settings)
    return window
end

function gabe.make_pixel_canvas(window)
    window = window or gabe.DEFAULT_WINDOW
    love.graphics.setDefaultFilter("nearest", "nearest")
    local canvas = love.graphics.newCanvas(window.width/window.scale, window.height/window.scale)
    canvas:setFilter("nearest", "nearest")
    DEFAULT_CANVAS = canvas
    return canvas
end

function gabe.begin_pixel_screen(canvas, clear_color)
    canvas = canvas or gabe.DEFAULT_CANVAS
    clear_color = clear_color or gabe.rgb(30, 30, 30)
    love.graphics.setCanvas(canvas)
    love.graphics.clear(clear_color)
end

function gabe.end_pixel_screen(window, canvas)
    window = window or gabe.DEFAULT_WINDOW
    canvas = canvas or gabe.DEFAULT_CANVAS
    love.graphics.setCanvas()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas, 0, 0, 0, window.scale, window.scale)
end

function gabe.draw_pixel_screen(window, canvas, drawcode)
    gabe.begin_pixel_screen(canvas, window.clear_color)
    drawcode()
    gabe.end_pixel_screen(window, canvas)
end

return gabe
