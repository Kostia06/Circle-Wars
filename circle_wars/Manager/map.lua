Map = {}
players = {}
particle_list = {}
bullets = {}
opponents_bullets = {}

me = ''
opponent = ''
player_settings = nill
function Map:load()
    self.server_type = ''
    self.menu_state = 'main'
    self.state = 'menu'
    Menu:load()
    Gameover:load()
    Settings:load()
end


function Map:update(dt)
    if self.server_type == 'server' then
        Server:update()

    elseif self.server_type == 'client' then
        Client:update()
    end
    if Gameover:checkGame() then
        self.state = 'gameover'
    end
    if self.state == 'game' then
        self:update_game(dt)
        if self.server_type == 'server' then
            opponent = tostring(Server.output[6])
        else
            opponent = tostring(Client.output[6])
        end
        for _, i in ipairs(inputs) do
            if i.id == 'Username' then
                me = i.text
            end
        end
    end
end

function Map:draw()
    if self.state =='menu' then
        self:draw_menu()
    elseif  self.state =='game' then
        Info:draw()
        self:draw_game()
    elseif self.state == 'gameover' then
        self:draw_game()
        Gameover:draw()
    end
end


function Map:draw_game()
    for _,i in ipairs(players) do
        i:draw()
    end
    for _,i in ipairs(bullets) do
        i:draw()
        if i.x < 0 or i.x > love.graphics.getWidth() or i.y < 0 or i.y > love.graphics.getHeight() then
            table.remove( bullets, _ )
        end 
    end


    opponents_bullets = {}
    if self.server_type == 'server' then
        Crosshair:draw({Server.output[3], Server.output[4]})
    elseif  self.server_type == 'client' then
        Crosshair:draw({Client.output[3], Client.output[4]}) 
    end

    -- setColor({0,0,0})
    -- rect('line', 0,0,screen.w,50)
    -- rect('line', 0,0,50,screen.h)
    -- rect('line', screen.w-50, 0, 50,screen.h)
    -- rect('line', 0,screen.h-50, screen.w, 50)
    showBullets()
end

function Map:update_game(dt)
    if player_settings ~= nill then
        Shoot:update()
        if self.server_type == 'server' then
            local x, y,boost = Server.output[1], Server.output[2], Server.output[5]
            Move:update(dt, {x,y}, boost)
            for _, i in ipairs(players) do
                if i.name == 'server' then
                    i.health = tonumber(Server.output[7])
                end
            end
        elseif self.server_type == 'client' then
            local x, y, boost = Client.output[1], Client.output[2], Client.output[5]
            Move:update(dt, {x,y}, boost)
            for _, i in ipairs(players) do
                if i.name == 'client' then
                    i.health = tonumber(Client.output[7])
                end
            end
        end

        for _,i in ipairs(players) do
            i:update(dt)
        end
        for _,i in ipairs(bullets) do
            i:update(dt)
        end
        bulletCollusiion()
    end 
end

function Map:make_players()
    if player_settings ~= nill then
        local info = player_settings
        table.insert(players, Player({screen.w/2, screen.h/2 -100}, 'client', {255,0,0}, info[1], info[2], info[3]))
        table.insert(players, Player({screen.w/2, screen.h/2+ 100}, 'server', {255,255,0}, info[1], info[2], info[3]))
    end
end

function Map:draw_menu()
    local list
    if self.menu_state == 'main' then
        list = {'Join Party','Create Party', 'Username', 'Settings'}
    else
        list = {'Player Health', 'Player Speed', 'Player Max Speed', 'Bullet Damage', 'Back'}
    end
    if self.server_type == 'server' then
        Server:draw_ip()
        Server:draw()
    elseif self.server_type == 'client' then
        Client:draw()
    end
    Menu:draw(list)
end






function Map:make_server()
    Server:load()
    self.server_type = 'server'
end


function Map:make_client()
    for _, input in pairs(inputs) do
        if input.id == 'Join Party' then
            Client:load(input.text)
            self.server_type = 'client'
        end
    end
end


