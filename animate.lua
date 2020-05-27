local function animate(imagePath, x, y, width, height, framesCount)
	local animation = {}

	local image = love.graphics.newImage(imagePath)
	local animation = animation
	animation.currFrame = -1
	animation.framesCount = framesCount
	animation.x = x
	animation.y = y
	animation.sx = 1
	animation.sy = 1
	animation.fx = 1
	animation.fy = 1
	animation.width = width
	animation.height = height
	animation.image = image
	animation.quad = love.graphics.newQuad(x, y, width, height, animation.image:getDimensions())

	function animation:next()
		-- increment current frame, with wrapping
		self.currFrame = ((self.currFrame + 1) % self.framesCount)
		self.quad:setViewport(self.currFrame * width + x, y, width, height, image:getDimensions())
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

	return animation
end

return animate
