Client = {}
local socket = require "socket"



function Client:load(ip_address)
	self.udp = socket.udp()
	self.output = nill
	self.info = ''
	self.settings = false
	local address, port = fromCode(ip_address), 8080
	self.udp = socket.udp()
	self.udp:setpeername(address, port)
	self.udp:settimeout(0)
end
function Client:sendGame()
	local x, y,info, boost, health
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
			info = addSpace({x,y,mouse_x, mouse_y, boost, i.text, health})
			for _, j in ipairs(list) do
				local pos = j[1] .. '/' .. j[2]
				info = info .. '-' .. tostring(pos)
			end
		end
	end
	return info
end
function Client:getSettings(list)
	local info = split(list, '-')
	player_settings = info
end
function Client:update()
	self.udp:send(self:sendGame())
	self.data =self.udp:receive()
	if self.data then
		if not self.settings then
			self:getSettings(self.data)
			self.settings = true
		else
			self.output = split(self.data, '-')
			self:sendGame()
		end
	end
end
function Client:draw()
	if self.data then
		Map:make_players()
		Map.state = 'game'
	end
end


