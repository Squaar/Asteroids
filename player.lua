player = {
	accel = 75,
	turnSpeed = 10,
	direction = 0.5 * math.pi,
	img = love.graphics.newImage("ship.png"),
	firing_speed = 0.5,
	shoot_timer = 0
}

function player_create()
	player.body = love.physics.newBody(world, width/2, height/2, "dynamic" )
	player.shape = love.physics.newRectangleShape(34, 44)
	player.fixture = love.physics.newFixture(player.body, player.shape)
	player.fixture:setUserData("player")
end

function player_update(dt)
	--when the player hits an asteroid
	if player.fixture:getUserData() == "player_D" then
		love.event.push("quit")
	end

	--turning
	if love.keyboard.isDown("right") then
		player.direction = player.direction + (dt * player.turnSpeed)
	elseif love.keyboard.isDown("left") then
		player.direction = player.direction - (dt * player.turnSpeed)
	end
	
	--forward and back
	if love.keyboard.isDown("up") then
		player.body:applyForce(player.accel * -math.cos(player.direction), player.accel * -math.sin(player.direction))
	elseif love.keyboard.isDown("down") then
		player.body:applyForce(player.accel * math.cos(player.direction), player.accel * math.sin(player.direction))
	end
	
	if love.keyboard.isDown(" ") then
		shoot(dt)
	end
	
	--screen looping
	if player.body:getX() <0 then
		player.body:setPosition(width-1, player.body:getY())
	elseif player.body:getX() > width then
		player.body:setPosition(1, player.body:getY())
	end
	if player.body:getY() <0 then
		player.body:setPosition(player.body:getX(), height-1)
	elseif player.body:getY() > height then
		player.body:setPosition(player.body:getX(), 1)
	end
end

function player_draw()
	love.graphics.draw(player.img, player.body:getX(), player.body:getY(), player.direction - 0.5 * math.pi, 1, 1, 17, 22)
end