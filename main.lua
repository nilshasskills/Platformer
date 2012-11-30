function love.load()
    player = { -- nice and organised.
        x = 0,
        y = 0,
		image = love.graphics.newImage("hamster.png"), -- let's just re-use this sprite.
		y_velocity = 0,
		jetpack_fuel = 0.4, -- note:not an actual jetpack. variable is the time (in seconds)
		-- you can hold spacebar and jump higher.
		jetpack_fuel_max = 0.4,
		x_velocity = 300
    }

    winW, winH = love.graphics.getWidth(), love.graphics.getHeight() -- this is just
    -- so we can draw it in a fabulous manner.
	
	gravity = 700
	jump_height = 600
end

function love.draw()
    love.graphics.rectangle("fill", 0, winH / 1.2, winW, winH / 1.2)
    love.graphics.translate(winW / 2, winH / 1.2) -- you don't need to understand this

    love.graphics.draw(player.image, player.x, -player.y, 0, 1, 1, 64, 103) -- trust me
    -- on the origin position. just trust me.
end

function love.update(dt)
	 if player.jetpack_fuel > 0 -- we can still move upwards
    and love.keyboard.isDown("z") then -- and we're actually holding space
        player.jetpack_fuel = player.jetpack_fuel - dt -- decrease the fuel meter
        player.y_velocity =  2 * player.y_velocity + jump_height * (dt / player.jetpack_fuel_max)
    end
    if player.y_velocity ~= 0 then -- we're probably jumping
        player.y = player.y + player.y_velocity * dt -- dt means we wont move at
        -- different speeds if the game lags
        player.y_velocity = player.y_velocity - gravity * dt
        if player.y < 0 then -- we hit the ground again
            player.y_velocity = 0
            player.y = 0
            player.jetpack_fuel = player.jetpack_fuel_max
        end
    end
	
	if love.keyboard.isDown("right") then
		player.x = player.x + player.x_velocity * dt
	end
	
	if love.keyboard.isDown("left") then
		player.x = player.x - player.x_velocity * dt
	end
end