Info = {}


function Info:draw()
    self:speed_bar()
    self:health()
    self:names()
end
function Info:names()
    local name
    for _, i in ipairs(inputs) do
        if i.id == 'Username' then
            if Map.server_type == 'server' then
                name = me .. ' / ' .. opponent
            else
                name = me .. ' / ' .. opponent
            end
        end
    end
    setColor({0,255,0})
    print(name, 15, 15)
end
function Info:health()
    for _, i in ipairs(players) do
        if i.name == Map.server_type then
            if tonumber(i.health) ~= nill then
                setColor({255,0,0})
                print(i.health .. '%', screen.w-80, 10)
            end
        end
    end
end
function Info:speed_bar()
    for _, i in ipairs(players) do
        if i.name == Map.server_type then
            local w = 300
			local ratio = i.max_speed_bar/w 
			local colors = {{0,255,0}, {255,255, 0}, {255,0,0}}
			local index = 1
			if i.speed/ratio/3 > 66.6 then
				index = 1
			end
			if i.speed/ratio/3 <66.6 then
				index = 2
			end
			if i.speed/ratio/3 < 33.3 then
				index = 3
			end
			if i.current_speed < 0 then
				i.current_speed = 0
			elseif i.current_speed > i.max_speed_bar then 
				i.current_speed = i.max_speed_bar
			end
			setColor(colors[index])
			rect('fill',(screen.w/2)-(w/2),screen.h-30,i.current_speed/ratio, 30,15,15  )
			setColor({0,0,0})
			rect('line',(screen.w/2)-(w/2),screen.h-30,w, 30,15,15  )
        end
    end
end