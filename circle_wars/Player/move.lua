Move = {}


function Move:update(dt, pos,  boost)
    for _, i in ipairs(players) do
        if i.name == Map.server_type then
            i.x = i.x + i.xvel * dt
			i.y = i.y + i.yvel * dt
			i.xvel = i.xvel * (1 - math.min(dt*i.friction, 1))
			i.yvel = i.yvel * (1 - math.min(dt*i.friction, 1))
		
			if key.isDown("d") and
			i.xvel < i.speed then
				i.xvel = i.xvel + i.speed * dt
			end
		
			if key.isDown("a") and
			i.xvel > -i.speed then
				i.xvel = i.xvel - i.speed * dt
			end
		
			if key.isDown("s") and
			i.yvel < i.speed then
				i.yvel = i.yvel + i.speed * dt
			end
		
			if key.isDown("w") and
			i.yvel > -i.speed then
				i.yvel = i.yvel - i.speed * dt
			end
		
			if key.isDown('space') and i.work_speed then
				i.boost = true
				i.speed = i.max_speed
				i.current_speed  = i.current_speed - 1
				if i.current_speed < 0 then
					i.work_speed = false
				end
			else
				i.speed = i.min_speed
				i.boost = false
				if i.current_speed < i.max_speed then
					i.current_speed = i.current_speed + 0.4 + dt
					if i.current_speed > 40 then
						i.work_speed = true
					end
				end
			end
		else 
			if tonumber(pos[1]) ~= nill and tonumber(pos[2]) ~= nill then
				i.x, i.y = tonumber(pos[1]), tonumber(pos[2])
				i.boost = toboolean[boost]
				bruh = i.boost
			end
		end
    end
end