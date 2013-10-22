require 'player'
require 'bullets'
require 'asteroids'
require 'world'

--called once when game is started up
function love.load()
	world_load()
	debugText = "load" .. "\n"
	show_debug = false
end

--updates everything
function love.update(dt)
	world:update(dt)
	player_update(dt)
	bullets_update(dt)
	asteroids_update(dt)
	world_update(dt)

	if string.len(debugText) > 600 then
		debugText = ""
	end
end

--button presses
function love.keypressed(key)
	--shoot bullets
	if key == (" ") then
		bullet_create()
		debugText = debugText .. "shoot" .. "\n"
	end
	
	--exit the game when escape is pushed
	if key == ("escape") then
		love.event.push("quit")
	end
	
	--debug
	if key == ("`") then
		show_debug = not show_debug
	end
end

--draw everything on the screen;
function love.draw()
	love.graphics.setFont(love.graphics.newFont("visitor1.ttf", 15))
	player_draw()
	bullets_draw()
	asteroids_draw()
	love.graphics.print("Score: " .. score, width - 100, 10)

	--debug
	if show_debug then
		love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
		love.graphics.print(debugText, 10, 25)
	end
end