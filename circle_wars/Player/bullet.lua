Shoot = {}
Crosshair = {}
function Shoot:update()
    for _,i in ipairs(players) do
        if i.name == Map.server_type then
            if mouse.isDown(1) and not clicked then
				clicked = true
                local x,y = mouse.getPosition()
                table.insert(bullets, Bullet({i.crosshair_x, i.crosshair_y}, i.color))
			end
        end
    end
end

function Crosshair:draw(pos)
    for _, i in ipairs(players) do
        if i.name == Map.server_type then
            local x,y = mouse.getPosition()
			local someAngle = math.atan2(i.y-y,i.x-x)
			i.crosshair_x, i.crosshair_y = i.w *math.cos(someAngle)*-1+i.x,i.w*math.sin(someAngle)*-1+ i.y
			setColor({0,0,0})
			circle('fill', i.crosshair_x, i.crosshair_y, 10)
			setColor(i.color)
			circle('line', i.crosshair_x, i.crosshair_y, 10)
        else
            if tonumber(pos[1]) ~= nill and tonumber(pos[2]) ~= nill then
                local x,y = tonumber(pos[1]), tonumber(pos[2])
                local someAngle = math.atan2(i.y-y,i.x-x)
                i.crosshair_x, i.crosshair_y = i.w *math.cos(someAngle)*-1+i.x,i.w*math.sin(someAngle)*-1+ i.y
                setColor({0,0,0})
                circle('fill', i.crosshair_x, i.crosshair_y, 10)
                setColor(i.color)
                circle('line', i.crosshair_x, i.crosshair_y, 10)
            end
        end
    end
end


function Bullet(pos, color)
    local mouse_x,mouse_y = mouse.getPosition()
    return{
        x= pos[1],
        y = pos[2],
        target = {mouse_x,mouse_y},
        size = 5,
        speed = 10,
        found = false,
        dir_x = 0,
        dir_y = 0,
        color = color,
        draw = function(self)
            setColor{self.color}
            circle('line', self.x, self.y,self.size )
        end,
        update = function(self, dt)
            if not self.found then
                local dir = findDir({self.x, self.y}, self.target, self.speed)
                self.dir_x, self.dir_y = dir[1], dir[2]
                self.found = true
            end
            self.x = self.x + self.dir_x 
            self.y = self.y + self.dir_y 
        end
    }

end


function bulletsList()
    local info = {}
    for _, i in ipairs(bullets) do
        table.insert(info, {i.x, i.y})
    end
    return info
end
function bulletCollusiion()
    for _, i in ipairs(players) do
        local player = {i.x, i.y}
        for index, j in ipairs(opponents_bullets) do
            local pos = {tonumber(j.x), tonumber(j.y)}
            if pos[1] ~= nill and pos[2] ~= nill then
                if findDistance(player, pos) <= 25 then
                    i.health = i.health -  tonumber(player_settings[4])
                    table.remove(opponents_bullets, index)
                end
            end
        end
        for index, j in ipairs(bullets) do
            local pos = {tonumber(j.x), tonumber(j.y)}
            if pos[1] ~= nill and pos[2] ~= nill then
                if findDistance(player,pos ) <= 25 then
                    i.health = tonumber(i.health) -  tonumber(player_settings[4])
                    table.remove(bullets, index)
                end
            end
        end
    end
end

function showBullets()
    if Map.server_type == 'server' then
        for _, i in ipairs(Server.output) do
            if _ > 7 then
                local info = split(i, '/')
                table.insert(opponents_bullets, info)
            end
        end
    else
        for _, i in ipairs(Client.output) do
            if _ > 7 then
                local info = split(i, '/')
                table.insert(opponents_bullets, info)
            end
        end
    end
    for _, i in ipairs(opponents_bullets) do
        if tonumber(i[1]) ~= nill and tonumber(i[2]) ~= nill then
            if Map.server_type == 'client' then
                setColor({255,255, 0})
                circle('line', tonumber(i[1]),tonumber(i[2]),5 )
            else
                setColor({255,0,0, 255})
                circle('line', tonumber(i[1]),tonumber(i[2]),5 )
            end
        end
    end
end