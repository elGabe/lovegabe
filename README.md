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
- [Ogmo](#ogmo)
  - [read_map](#read_map)
---
## Utils
### add
Adds an element to a table. Just an alias for `table.insert`.

### del
Deletes an element from a table. `table.remove` takes in a position in the table, while `del` takes a specific element.

### approach
Taken from my GameMaker days, returns a value that approaches "target" from "start" by a "shift" amount.

### lengthdir_x
Straight from the GameMaker [documentation](https://docs.yoyogames.com/source/dadiospice/002_reference/maths/real%20valued%20functions/lengthdir_x.html), it returns the horizontal X component of the vector determined by "length" and "direction".\
The same can be achieved by using `math.cos(direction) * length`.

- Expects the `direction` argument to be in **radians**.
### lengthdir_y
Also from the GameMaker [documentation](https://docs.yoyogames.com/source/dadiospice/002_reference/maths/real%20valued%20functions/lengthdir_y.html), it returns the vertical Y component of the vector determined by "length" and "direction".\
The same can be achieved by using `math.sin(direction) * length`.

- Expects the `direction` argument to be in **radians**.

### lengthdir
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
Converts RGB color from a 0-255 range to 0-1. Assumes alpha to be 1 (fully opaque).

### rgba
Converts RGB color from a 0-255 range to 0-1. Expects an `a` argument that represents alpha in a 0-255 range.

### hsl
Converts HSL color to RGB. Inputs and outputs 0-255 range.

[Love2D Page](https://love2d.org/wiki/HSL_color)

### read_file
Reads a file located at `path` and returns its contents as a string.

## Sprites
### make_sprite
Creates a sprite object from **'texture'** with a size of **'width'** and **'height'**. The sprite will contain **'frames'** number of frames or subimages.

## Ogmo
### read_map
Reads a .json map file located at `path` and creates a map table to hold its values.

## Acknowledgements
- Love2D
- json.lua, by rxi (https://github.com/rxi/json.lua)
- YoYo Games' GameMaker: Studio (1 & 2)
- Ogmo Editor 3
