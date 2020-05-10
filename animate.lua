local function animate(imagePath, x, y, width, height, framesCount)
	local animation = {}

	local image = love.graphics.newImage(imagePath)
	local animation = animation
	animation.currFrame = -1
	animation.framesCount = framesCount
	animation.x = x
	animation.y = y
	animation.width = width
	animation.height = height
	animation.image = image
	animation.quad = love.graphics.newQuad(x, y, width, height, animation.image:getDimensions())

	function animation:next()
		-- increment current frame, with wrapping
		self.currFrame = ((self.currFrame + 1) % self.framesCount)
		self.quad:setViewport(self.currFrame * width + x, y, width, height, image:getDimensions())
	end

	function animation:drawFrame(px, py)
		love.graphics.draw(self.image, self.quad, px, py)
	end

	return animation
end

return animate
