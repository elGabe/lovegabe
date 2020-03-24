-- Libary for pixel perfect drawing in Love2D
-- By Gabe <3

-- V1

pixels = {}

-- Window Settings
pixels.DEFAULT_SCREEN_SETTINGS = {
    fullscreen = false,
    fullscreentype = "desktop",
    vsync = false,
    msaa = 0,
    resizable = true
}

pixels.DEFAULT_WINDOW = {
    128,                        -- Width
    128,                        -- Height
    4,                          -- Zoom
    DEFAULT_SCREEN_SETTINGS     -- Settings
}

pixels.DEFAULT_CANVAS = {}

function pixels.make_window(w, h, z, t)
    z = z or 1
    t = t or DEFAULT_SCREEN_SETTINGS
    
    local screen = {}
    screen.width = w * z
    screen.height = h * z
    screen.zoom = z
    screen.settings = t
    return screen
end

-- Makes a new canvas for pixel-perfect drawing
function pixels.make_canvas(window)
    window = window or DEFAULT_WINDOW
    love.graphics.setDefaultFilter("nearest", "nearest")
    local canvas = love.graphics.newCanvas(window.width/window.zoom, window.height/window.zoom)
    canvas:setFilter("nearest", "nearest")
    return canvas
end

-- Makes a new canvas and sets widow mode
function pixels.make_screen(window)
    window = window or DEFAULT_WINDOW
    -- Make a pixel perfect canvas
    DEFAULT_CANVAS = pixels.make_canvas(window)
    
    -- Set window mode
    pixels.set_window_mode(window)

    return DEFAULT_CANVAS
end

-- Starts the pixel perfect canvas
-- Call on love.draw
function pixels.begin_canvas(c)
    c = c or DEFAULT_CANVAS
    love.graphics.setCanvas(c)
    love.graphics.clear(rgb(30, 30, 30))
end

-- Draw pixel-perfect canvas
-- Call on love.draw after begin_canvas
function pixels.draw_canvas(window, c)
    window = window or DEFAULT_WINDOW
    c = c or DEFAULT_CANVAS
    love.graphics.setCanvas()
    love.graphics.draw(c, 0, 0, 0, window.zoom, window.zoom)
end

function pixels.set_window_mode(window)
    window = window or DEFAULT_WINDOW
    local w = window.width
    local h = window.height
    love.window.setMode(w, h, window.settings)
end

return pixels