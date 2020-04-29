#animate

-----

Library for easy animation in love2d

```lua
love.graphics.setDefaultFilter("nearest", "nearest", 0)

-- require "animate" returns a functions that creates animations
local animate = require "animate"
-- create the animation, calling that function
local animation = animate("sprites.png", 16, 16, 16, 16, 4)

-- draw the animation at the given coordinates (x, y)
function love.draw()
	animation:drawFrame(100, 100)
end

-- basic timer, calls animation:next every now and then
local counter = 0
function love.update(dt)
	counter = counter + dt
	if counter > 0.15 then
		counter = 0
		-- animation:next() is a function which switches to the
		-- next frame in the spritesheet
		animation:next()
	end
end
```

spritesheet:  
![alt text][spritesheet]
how it looks:  
![alt text][fire animation]

[spritesheet]: https://github.com/theamazingwaffle/love2d-animate/example/sprites.png
[fire animation]: https://github.com/theamazingwaffle/love2d-animate/example/fire.gif
