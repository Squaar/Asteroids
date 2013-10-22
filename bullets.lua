bullets = { 
	img = love.graphics.newImage("bullet.png")
}

function shoot(dt)
	if player.shoot_timer >= player.firing_speed then
		bullet_create()
		player.shoot_timer = 0
	else
		player.shoot_timer = player.shoot_timer + dt
	end
end

function bullet_create()
	--create bullet
	table.insert(bullets, {})
		bullets[#bullets].direction = player.direction
		bullets[#bullets].body = love.physics.newBody(world, player.body:getX() - math.cos(bullets[#bullets].direction) * 40, player.body:getY() - math.sin(bullets[#bullets].direction) * 40, "dynamic")
		bullets[#bullets].shape = love.physics.newRectangleShape(5, 20)
		bullets[#bullets].fixture = love.physics.newFixture(bullets[#bullets].body, bullets[#bullets].shape)
		bullets[#bullets].speed = player.body:getLinearVelocity() + 1000
		bullets[#bullets].fixture:setUserData("bullet")
	
	-- push bullet forward
	bullets[#bullets].body:applyForce(-(bullets[#bullets].speed * math.cos(bullets[#bullets].direction)), -(bullets[#bullets].speed * math.sin(bullets[#bullets].direction)))
end

function bullets_update(dt)
	--checks for out of bounds
	for i, o in ipairs(bullets) do
		if (o.body:getX() < -10) or (o.body:getX() > width + 10) or (o.body:getY() < -10) or (o.body:getY() > height + 10) then
            table.remove(bullets, i)
        end

		if o.fixture:getUserData() == "bullet_D" then
			debuxText = debugText .. "deleting" .. "\n"
			o.body:destroy()
			table.remove(bullets, i)
		end
    end
end

function bullets_draw()
	for i, o in ipairs(bullets) do
		love.graphics.draw(bullets.img, o.body:getX(), o.body:getY(), o.direction - 0.5 * math.pi, 1, 1, 3, 3)
	end
end