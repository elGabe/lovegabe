# Love, Gabe
A set of Love2D tools by Gabe D.

## Table of Contents
- [Utils](#utils)
  - [add](#add)
  - [del](#del)
  - [approach](#approach)
  - [lengthdir_x](#lengthdir_x)
  - [lengthdir_y](#lengthdir_y)
  - [lengthdir](#lengthdir)
  - [rgb](#rgb)
  - [rgba](#rgba)
  - [hsl](#hsl)
  - [read_file](#read_file)
- [Sprites](#sprites)
  - [make_sprite](#make_sprite)
---
## Utils
### add
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|table    |The table to add an item to| table|
|item|The item to add to the table| any

Adds an element to a table. Just an alias for `table.insert`.

### del
|Arguments| Description| Type  |
|:-------:|:----------|:-----:|
|table|The table to remove an item from|table|
|item|The item to remove|any|

Deletes an element from a table. `table.remove` takes in a position in the table, while `del` takes a specific element.

### approach
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|start|Value to start approaching from| number
|target|Value to approach towards|number
|shift|Amount to approach by|number

Taken from my GameMaker days, returns a value that approaches "target" from "start" by a "shift" amount.

### lengthdir_x
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|length|Distance from the point to return|number
|direction|Angle of the point to return|number

Straight from the GameMaker [documentation](https://docs.yoyogames.com/source/dadiospice/002_reference/maths/real%20valued%20functions/lengthdir_x.html), it returns the horizontal X component of the vector determined by "length" and "direction".\
The same can be achieved by using `math.cos(direction) * length`.

- Expects the `direction` argument to be in **radians**.
### lengthdir_y
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|length|Distance from the point to return|number
|direction|Angle of the point to return|number

Also from the GameMaker [documentation](https://docs.yoyogames.com/source/dadiospice/002_reference/maths/real%20valued%20functions/lengthdir_y.html), it returns the vertical Y component of the vector determined by "length" and "direction".\
The same can be achieved by using `math.sin(direction) * length`.

- Expects the `direction` argument to be in **radians**.

### lengthdir
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|length|Distance from the point to return|number
|direction|Angle of the point to return|number

Returns both X and Y components of the vector determined by "length" and "direction" in that order.

For example:
```
local x, y = lengthdir(a, b)
```
is equivalent to
```
local x = lengthdir_x(a, b)
local y = lengthdir_y(a, b)
```

### rgb
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|r|Red color value (0-255)|number
|g|Green color value (0-255)|number
|b|Blue color value (0-255)|number

Converts RGB color from a 0-255 range to 0-1. Assumes alpha to be 1 (fully opaque).

### rgba
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|r|Red color value (0-255)|number
|g|Green color value (0-255)|number
|b|Blue color value (0-255)|number
|a|Alpha color value (0-255)|number

Converts RGB color from a 0-255 range to 0-1. Expects an `a` argument that represents alpha in a 0-255 range.

### hsl
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|h|Hue value (0-255)|number
|s|Saturation value (0-255)|number
|l|Lightness value (0-255)|number

Converts HSL color to RGB. Inputs and outputs 0-255 range.

[Love2D Page](https://love2d.org/wiki/HSL_color)

### read_file
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|path|Path of the file to read|string

Reads a file located at `path` and returns its contents as a string.

# Sprite
This object contains useful information for drawing a texture, or parts of a texture (frames) to the screen. Actors can have multiple sprites for different animations or a single sprite that contains frames for all animations.

## Properties

### texture
Type: **LOVE2D Texture**

This is the image loaded and drawn by the sprite.

### width
Type: **number**

The width of the visible frame on screen.

### height
Type: **number**

The height of the visible frame on screen.

### frames
Type: **table**

Collection of frames avaliable to this sprite.

### frame_index
Type: **number**

Current frame being drawn.

## Functions
### make_sprite
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|texture|Texture to assign to sprite|LOVE2D Texture
|width|Width of the sprite frame|number
|height|Height of the sprite frame|number
|frames|Number of frames the texture should be split into|number

Creates a sprite object from **'texture'** with a size of **'width'** and **'height'**. The sprite will contain **'frames'** number of frames or subimages.

### draw
|Arguments| Description| Type  |
|:-------:|:-----------|:-----:|
|x|X position to draw the sprite from|number
|y|Y position to draw the sprite from|number
|angle|Angle of the sprite being drawn|number

# BBox
Checks for AABB collisions.

## Acknowledgements
- Love2D
- json.lua, by rxi (https://github.com/rxi/json.lua)
- YoYo Games' GameMaker: Studio (1 & 2)
