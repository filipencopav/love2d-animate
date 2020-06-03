# animate

-----

Clone this repo and run love2d:  
```bash
love example/
```

Library for easy animation in love2d

```lua
love.graphics.setDefaultFilter("nearest", "nearest", 0)

local animate = require "animate"

--- creates a new animation
--  is the same as `animate.new`
--  @param imagePath Path to the spritesheet
--  @param x Offset on the x axis
--  @param y Offset on the y axis
--  @param width One frame's width
--  @param height One frame's height
--  @param framesCount Total amount of frames
--  @param fps Framerate.
--  NOTE:
--  If you intend on using FPS, you will need to call
--  animation:update(dt) inside your update function
--  If you don't intend on using FPS, you will need to call
--  animation:next() every frame yourself
local animationWithFPS = animate("sprites.png", 16, 16, 16, 16, 4, 10)

local animationWithoutFPS = animate("sprites.png", 16, 16, 16, 16, 4)
local fps = 10
local timer = 1/fps
function love.update(dt)
	timer = timer - dt
	if timer <= 0 then
		animationWithoutFPS:next()
		timer = 1/fps
	end
	-- with FPS, all you have to do is:
	animationWithFPS:update(dt)
end

function love.draw()
	love.graphics.push()
	love.graphics.scale(4)
	animationWithFPS:drawFrame(100, 100)
	animationWithoutFPS:drawFrame(50, 100)
	love.graphics.pop()
end
```

spritesheet:  
![alt text][spritesheet]  
how it looks:  
![alt text][fire animation]

[spritesheet]: https://github.com/theamazingwaffle/love2d-animate/blob/master/example/sprites.png "Spritesheet"
[fire animation]: https://github.com/theamazingwaffle/love2d-animate/blob/master/example/fire.gif "Animation"
