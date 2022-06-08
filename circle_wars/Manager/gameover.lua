Gameover = {}

function Gameover:load()
    self.name = ''
    table.insert(buttons, newButton(
        {screen.w/2, screen.h/2 +150},
        {250,64},
        'Go To Main',
        function()
            self:reset()
        end
    ))
end
function Gameover:reset()
    Map.menu_state = 'main'
    Map.server_type = ''
    Map.state = 'menu'
    players = {}
    opponents_bullets = {}
    bullets = {}
    self.name = ''
    Client.udp = nill
    Server.udp = nill

    for _,  i in ipairs(inputs) do
        if i.id == 'Join Party' then
            i.text = ''
        end
    end
end
function Gameover:draw()
    self.name = self:checkWinner()
    local text = 'Winner is ' .. self.name
    if text ~= nill then
        local w, h = font:getWidth(text), font:getHeight(text)
        setColor({0,0,0, 0.5})
        rect('fill', 0,0, screen.w, screen.h)
        setColor({255,255,255})
        print(text, screen.w/2 - w/2, screen.h/2)
        Menu:draw({'Go To Main'})
    end

end


function Gameover:checkWinner()
    local list = {}
    for _, i in ipairs(players) do
        table.insert(list, i.health)
    end
    table.sort(list)
    for _, i in ipairs(players) do
        if tonumber(i.health) ~= nill then
            if tonumber(i.health) == list[#list] then
                if i.name == Map.server_type then
                    return me
                else
                    return opponent
                end
            end
        end
    end
end
function Gameover:checkGame()
    for _, i in ipairs(players) do
        if tonumber(i.health) ~= nill then
            if tonumber(i.health)  <= 0 then
                return true
            end
        end
    end
end
