function world_load()
	--set up world
	love.graphics.setMode(1024, 768, false, true, 16)
	love.physics.setMeter(100)
	world = love.physics.newWorld(0,0,true)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	
	player_create()
	score = 0

	asteroid_freq = 5
	asteroid_timer = 0
end

function world_update(dt)
	if asteroid_timer >= asteroid_freq then
		asteroid_create("big", math.random(width, width + 1), math.random(height, height + 1))
		asteroids[#asteroids].body:applyForce(math.random(-10000, 10000), math.random(-10000, 10000))
		asteroid_timer = 0
	else
		asteroid_timer = asteroid_timer + dt
	end
end

--collisions
function beginContact(a, b, coll)
	debugText = debugText .. "collision" .. "\n"
	
	--bullet vs asteroid
	if a:getUserData() == "bullet" and b:getUserData() == "asteroid" then
		debugText = debugText .. a:getUserData() .. " Collision " .. b:getUserData() .. "\n"
		a:setUserData("bullet_D")
		b:setUserData("asteroid_D")
	end
	if b:getUserData() == "bullet" and a:getUserData() == "asteroid" then
		debugText = debugText .. b:getUserData() .. " Collision " .. a:getUserData() .. "\n"
		b:setUserData("bullet_D")
		a:setUserData("asteroid_D")
	end

	--player vs asteroid
	if a:getUserData() == "player" and b:getUserData() == "asteroid" then
		debugText = debugText .. a:getUserData() .. " Collision " .. b:getUserData() .. "\n"
		a:setUserData("player_D")
	end
	if b:getUserData() == "player" and a:getUserData() == "asteroid" then
		debugText = debugText .. b:getUserData() .. " Collision " .. a:getUserData() .. "\n"
		b:setUserData("player_D")
	end
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

function postSolve(a, b, coll)
end