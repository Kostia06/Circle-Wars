Player = {}
function Player(pos, name, color, health, speed, max_speed)
	return{
		x = pos[1],
		y = pos[2],
		color = color,
		w = 30,
		h = 30,
		xvel = 0,
		yvel = 0,
		name = name,
		friction = 1,
		speed = tonumber(speed),
		min_speed = tonumber(speed),
		max_speed = tonumber(max_speed),
		max_speed_bar = 100,
		current_speed = 100,
		timer_speed = 0,
		work_speed = true,
		border_timer = 0,
		border = false,
		boost = false,
		crosshair_x = 0,
		crosshair_y= 0,
		health = tonumber(health),
		draw = function(self)
			local x,y = mouse.getPosition()
			setColor(self.color)
			love.graphics.getLineWidth(15)
			circle('line', self.x, self.y, self.w)
			if self.boost then
				table.insert(particle_list,Particle:new(self.x, self.y, self.name))
				for _,i in ipairs(particle_list) do
					i:draw(self.color)
				end
			end
		end,


		update = function(self, dt)
			self:border_check(dt)
			for _,i in ipairs(particle_list) do
				if i.name == self.name then
					i:update()
					if i.alpha <= 0 then
						table.remove(particle_list, _)
					end
				end
			end
		end,
		border_check = function(self, dt)
			local x, y, w, h= self.x, self.y, self.w, self.h
			if self.bordered then
				self.border_timer = self.border_timer + dt
				if self.border_timer > 0.3 then
					self.bordered = false
					self.border_timer = 0
				end
			end

			if x+ w/2 < 0 and not self.bordered then
				self.x = screen.w + w 
				self.bordered = true
			elseif x + w/2 > screen.w  and not self.bordered then
				self.x = 0 - w 
				self.bordered = true
			elseif y+h/2 < 0 and not self.bordered then
				self.y = screen.h + h 
				self.bordered = true
			elseif y+h/2 > screen.h  and not self.bordered then
				self.y = 0-h 
				self.bordered = true
			end
		end,
	}
end







