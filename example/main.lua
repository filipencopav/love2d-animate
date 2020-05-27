love.graphics.setDefaultFilter("nearest", "nearest", 0)

local animate = require "animate"
local animation = animate("sprites.png", 16, 16, 16, 16, 4)

function love.draw()
	love.graphics.push()
	love.graphics.scale(4)
	animation:drawFrame(100, 100)
	love.graphics.pop()
end

-- basic timer, calls animation:next every now and then
local counter = 0
function love.update(dt)
	counter = counter + dt
	if counter > 0.15 then
		counter = 0
		animation:next()
	end
end
