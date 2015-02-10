-- constants and stuff
arc_path = 'arc/'
require(arc_path .. 'arc')
_navi = require(arc_path .. 'navi')

local lastCall = 0

function love.load()
	-- brows --

	brow = love.graphics.newImage("graphics/brow.png")
	
	-- eyes --
	
	eyeu = love.graphics.newImage("graphics/eyeu.png")
	eyef = love.graphics.newImage("graphics/eyef.png")
	eyed = love.graphics.newImage("graphics/eyed.png")
	eyeru = love.graphics.newImage("graphics/eyeru.png")
	eyelu = love.graphics.newImage("graphics/eyelu.png")
	eyerd = love.graphics.newImage("graphics/eyerd.png")
	eyeld = love.graphics.newImage("graphics/eyeld.png")
	eyer = love.graphics.newImage("graphics/eyer.png")
	eyel = love.graphics.newImage("graphics/eyel.png")
	eyec = love.graphics.newImage("graphics/eyec.png")


	-- mouths --
	
	mouth = love.graphics.newImage("graphics/mouth.png")
	moutho = love.graphics.newImage("graphics/moutho.png")
	
	-- filters --
	
	brow:setFilter("nearest", "nearest")
	eyeu:setFilter("nearest", "nearest")
	eyef:setFilter("nearest", "nearest")
	eyed:setFilter("nearest", "nearest")
	eyeru:setFilter("nearest", "nearest")
	eyelu:setFilter("nearest", "nearest")
	eyerd:setFilter("nearest", "nearest")
	eyeld:setFilter("nearest", "nearest")
	eyer:setFilter("nearest", "nearest")
	eyel:setFilter("nearest", "nearest")
	eyec:setFilter("nearest", "nearest")
	mouth:setFilter("nearest", "nearest")
	moutho:setFilter("nearest", "nearest")
	
	-- messages --
	m = {}
    m[1] = _navi:new(' Hello!|, My name is Byte!|, Pleased to|n meet ya!',
        {x=0, y=264})
end

function love.keypressed(key)
	input = ""
end

function love.mousepressed(x, y, mkey)
	arc.set_key(mkey)
end

function love.mousereleased(x, y, mrkey)
end

function love.update(dt)
	arc.check_keys(dt)
end

function love.draw()
	msg = _navi:new("test")
	camera:set()
	love.graphics.draw(brow, 0, 0)
	if blink(6, 0.1) then
		if love.window.hasMouseFocus() then
			eyeFollow()
		else
			love.graphics.draw(eyer, 30, 9)
			love.graphics.draw(eyer, 3, 41, 0, -1, 1, 32, 32)
			
			if key == "s" then
				love.graphics.print(input, 0, 64)
			end
		end
	end
	if m[1]:is_over() then
		love.graphics.draw(mouth, 0, 0)
	else
		if talk(0.1, 0.15) then
			love.graphics.draw(mouth, 0, 0)
		end
	end
	love.graphics.rectangle("fill", 0, 64, 64, 1)
	camera:unset()
	m[1]:play(0, 0)
	arc.clear_key()
end

---------------
-- functions --
---------------

-- these are really hacky, don't mind them

function eyeFollow()
	local x, y = love.mouse.getPosition()

	-- left eye --
	
	if y - 16/camera.sY >= 0 and y - 34/camera.sY <= 0 then
		if x - 38/camera.sX <= 0 then
			love.graphics.draw(eyer, 30, 9)
		end
		if x - 55/camera.sX >= 0 then
			love.graphics.draw(eyel, 30, 9)
		end
		if x - 38/camera.sX > 0 and x - 55/camera.sY < 0 then
			love.graphics.draw(eyef, 30, 9)
		end
	end
	
	if y - 16/camera.sY < 0 then
		if x - 38/camera.sX <= 0 then
			love.graphics.draw(eyeru, 30, 9)
		end
		if x - 55/camera.sX >= 0 then
			love.graphics.draw(eyelu, 30, 9)
		end
		if x - 38/camera.sX > 0 and x - 55/camera.sY < 0 then
			love.graphics.draw(eyeu, 30, 9)
		end
	end
	
	if y - 34/camera.sY > 0 then
		if x - 38/camera.sX <= 0 then
			love.graphics.draw(eyerd, 30, 9)
		end
		if x - 55/camera.sX >= 0 then
			love.graphics.draw(eyeld, 30, 9)
		end
		if x - 38/camera.sX > 0 and x - 55/camera.sY < 0 then
			love.graphics.draw(eyed, 30, 9)
		end
	end
	
	-- right eye --
	
	if y - 16/camera.sY >= 0 and y - 34/camera.sY <= 0 then
		if x - 12/camera.sX <= 0 then
			love.graphics.draw(eyel, 3, 41, 0, -1, 1, 32, 32)
		end
		if x - 26/camera.sX >= 0 then
			love.graphics.draw(eyer, 3, 41, 0, -1, 1, 32, 32)
		end
		if x - 12/camera.sX > 0 and x - 26/camera.sY < 0 then
			love.graphics.draw(eyef, 3, 41, 0, -1, 1, 32, 32)
		end
	end

	if y - 16/camera.sY < 0 then
		if x - 12/camera.sX <= 0 then
			love.graphics.draw(eyelu, 3, 41, 0, -1, 1, 32, 32)
		end
		if x - 26/camera.sX >= 0 then
			love.graphics.draw(eyeru, 3, 41, 0, -1, 1, 32, 32)
		end
		if x - 12/camera.sX > 0 and x - 26/camera.sY < 0 then
			love.graphics.draw(eyeu, 3, 41, 0, -1, 1, 32, 32)
		end
	end
	
	if y - 34/camera.sY > 0 then
		if x - 12/camera.sX <= 0 then
			love.graphics.draw(eyeld, 3, 41, 0, -1, 1, 32, 32)
		end
		if x - 26/camera.sX >= 0 then
			love.graphics.draw(eyerd, 3, 41, 0, -1, 1, 32, 32)
		end
		if x - 12/camera.sX > 0 and x - 26/camera.sY < 0 then
			love.graphics.draw(eyed, 3, 41, 0, -1, 1, 32, 32)
		end
	end
end

function blink(x, length)
	local ltime = love.timer.getTime()
	if ltime <= lastCall + x then
	elseif ltime <= lastCall + x + length then
	    love.graphics.draw(eyec, 30, 9)
		love.graphics.draw(eyec, 3, 41, 0, -1, 1, 32, 32)
		return false
	else
		lastCall = ltime
		return true
	end
	return true
end

function talk(x, length)
	local ltime = love.timer.getTime()
	if ltime <= lastCall + x then
	elseif ltime <= lastCall + x + length then
	    love.graphics.draw(moutho, 0, 0)
		return false
	else
		lastCall = ltime
		return true
	end
	return true
end

---------------
--   camera  --
---------------

camera = {}
camera.x = 0
camera.y = 0
camera.sX = 0.25
camera.sY = 0.25

function camera:set()
  love.graphics.push()
  love.graphics.scale(1 / self.sX, 1 / self.sY)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:setScale(sx, sy)
  self.sX = sx or self.sX
  self.sY = sy or self.sY
end