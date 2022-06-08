Server = {}
local start = false
local socket = require('socket')

 function Server:load()
	self.udp = socket.udp()
	ip = socket.dns.toip(socket.dns.gethostname()) 
	self.udp:setsockname(ip, 8080)
	self.udp:settimeout(0)
	self.settings = false
 end

function Server:sendGame()
	local x, y, info, boost, health
	local mouse_x, mouse_y = mouse.getPosition()
	for _, i in ipairs(players) do
		if i.name == Map.server_type then
			x, y = i.x, i.y
			boost = i.boost
		end
	end
	for _, i in ipairs(players) do
		if i.name ~= Map.server_type then
			health = i.health
		end
	end

	for _, i in ipairs(inputs) do
		if i.id == 'Username' then
			local list = bulletsList()
			info = addSpace({x,y,mouse_x, mouse_y,boost,i.text,health })
			for _, j in ipairs(list) do
				local pos = j[1] .. '/' .. j[2]
				info =  info .. '-' .. tostring(pos)
			end
		end
	end
	return info
end
function Server:sendSettings()
	local health, speed, max_speed, damage, info
	for _, i in ipairs(inputs) do
		if i.id == 'Player Health' then
			health = i.text
		elseif i.id == 'Player Speed' then
			speed = i.text
		elseif i.id == 'Player Max Speed' then
			max_speed = i.text
		elseif i.id == 'Bullet Damage' then
			damage = i.text
		end
	end
	info ={health, speed, max_speed, damage}
	return addSpace(info)
end
function Server:update()
	local msg_or_ip, port_or_nil
	self.data, msg_or_ip, port_or_nil = self.udp:receivefrom()
	if not self.settings then
		player_settings = split(self:sendSettings(), '-')
	end
	if self.data then
		self.output = split(self.data, '-')
		if not self.settings then
			self.udp:sendto(self:sendSettings(), msg_or_ip, port_or_nil)
			self.settings = true
		else
			self.udp:sendto(self:sendGame(), msg_or_ip, port_or_nil)
		end
	end
end

function Server:draw_ip()
	local text = 'Your code: ' .. intoCode(ip)
	local w, h = font:getWidth(text), font:getHeight(text)
	love.graphics.setColor(255,255,255)
	love.graphics.print(text, font, screen.w/2-w/2, 300)
end

function Server:draw()
	if self.data then
		Map:make_players()
		Map.state = 'game'
	end
end


