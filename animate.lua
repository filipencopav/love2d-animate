local animate = {}

local animation = {}
animation.__index = animation

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

local function new(imagePath, x, y, width, height, framesCount, fps)
	imagePath = assert(imagePath, "Please provide an image path")

	local image = love.graphics.newImage(imagePath)
	fps = fps or 60
	local mt = {
		frame = -1,
		framesCount = framesCount,
		x = assert(x, "Please provide the x offset"),
		y = assert(y, "Please provide the y offset"),
		sx = 1,
		sy = 1,
		fx = 1,
		fy = 1,
		width = assert(width, "Please provide the frame width"),
		height = assert(height, "Please provide the frame height"),
		image = image,
		quad = love.graphics.newQuad(x, y, width, height, image:getDimensions()),
		fps = fps,
		timer = 1 / fps,
	}
	return setmetatable(mt, animation)
end

function animation:next()
	-- increment current frame, with wrapping
	self.frame = ((self.frame + 1) % self.framesCount)
	self.quad:setViewport(self.frame * self.width + self.x, self.y, self.width, self.height, self.image:getDimensions())
end

function animation:update(dt)
	self.timer = self.timer - dt
	if self.timer <= 0 then
		self.timer = 1 / self.fps
		self:next()
	end
end

function animation:drawFrame(x, y)
	love.graphics.draw(self.image, self.quad, x, y, 0, self.sx * self.fx, self.sy * self.fy)
end

function animation:drawFrameCentered(x, y)
	love.graphics.draw(self.image, self.quad, x, y, 0, self.sx * self.fx, self.sy * self.fy, self.width/2, self.height/2)
end

function animation:setScale(x, y)
	self.sx = x or self.sx
	self.sy = y or self.sy
end

function animation:setFlip(x, y)
	self.fx = x or self.fx
	self.fy = y or self.fy
end

return setmetatable({
	new = new,
}, {
	__call = function(_, ...) return new(...) end
})
