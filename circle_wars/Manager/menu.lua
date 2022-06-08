Menu = {}
inputs = {}
buttons = {}
labels = {}


function newButton(pos,size, text, fn)
    return {
        pos =pos,
        size=size,
        text= text,
        fn = fn
    }
end
function newInput(pos, size, id, fn, text)
    return {
        pos =pos,
        size=size,
        text= text,
        fn = fn,
        id = id,
        clicked = false,
        max = false
    }
end

function Menu:load()
    table.insert(inputs, newInput(
        {screen.w/2,150},
        {250,64},
        'Username',
        function()

        end,
        ''
    ))
    table.insert(buttons, newButton(
        {screen.w/2,250},
        {250, 44},
        'Create Party',
        function()
            Map:make_server()
        end
    ))
    table.insert(inputs, newInput(
        {screen.w/2, 400},
        {250,64},
        'Join Party',
        function()
            Map:make_client()
        end,
        ''

    ))
    table.insert(buttons, newButton(
        {screen.w/2, 500},
        {250,64},
        'Settings',
        function()
            Map.menu_state = 'settings'
        end

    ))
end
function Menu:draw(list)
    self:buttonDraw(list)
    self:inputDraw(list)
end

function Menu:buttonDraw(list)
    for i, button in ipairs(buttons) do
        if inList(button.text, list) then
            local text = button.text
            local x,y = button.pos[1], button.pos[2] 
            local w, h = button.size[1], button.size[2]
            local new_x, new_y = x - w/2, y-h/2
            local font_w, font_h = font:getWidth(text), font:getHeight(text)
            local fn = button.fn
            local mx, my = mouse.getPosition()
            setColor({255,255,255})
            rect('line',new_x,new_y,w,h, 15, 15 )
            if mx > new_x and mx < new_x+w and my > new_y and my < new_y +h  then
                love.graphics.setColor(100, 100,100, 100)
                if mouse.isDown(1) and not clicked then
                    fn()
                    clicked = true
                end
            else
                setColor({255,255,255})
            end
            setColor({255,255,255})
            print(text,font, x-font_w/2, y-font_h/2)
        end
    end
end

function Menu:inputDraw(list)
    for i, input in ipairs(inputs) do
        if inList(input.id, list) then
            local id = input.id
            local text = input.text
            local x,y = input.pos[1], input.pos[2] 
            local w, h = input.size[1], input.size[2]
            local new_x, new_y = x - w/2, y-h/2
            local text_w, text_h = font:getWidth(text), font:getHeight(text)
            local id_w, id_h = font:getWidth(id), font:getHeight(id)
            local mx, my = mouse.getPosition()
            local point_1 = {}
            point_1.x, point_1.y = new_x, new_y+h/2
            if text_w > w then
                input.max = true
            else
                input.max = false
            end
            if mx > new_x and mx < new_x+w and my > new_y and my < new_y +h  then
                if mouse.isDown(1) then
                    input.clicked = true
                end
            elseif mouse.isDown(1) then
                input.clicked = False
                if string.len(input.text) > 0 then
                    input.fn()
                end
            end
            if input.clicked then
                love.graphics.setColor(155,155,155)
            else
                love.graphics.setColor(255,255,255)
            end

            love.graphics.setColor(255,255,255)
            if input.clicked then
                love.graphics.print(text .. '|',font, x-text_w/2, y-text_h/1.5)
                love.graphics.rectangle('fill',point_1.x,y-text_h/2+id_h,w, 2)
            else
                love.graphics.print(text,font, x-text_w/2, y-text_h/3.5+10)
                if string.len(input.text) then 
                    love.graphics.rectangle('fill',point_1.x,y-text_h/3.5+id_h+10,w, 2)
                end
                love.graphics.print(id,font, x-id_w/2, y-id_h)
            end
        end
    end
end

function love.textinput(key)
    Menu:keypresses(key)
end


function love.keypressed(key)
    Menu:delete(key)
end

function Menu:keypresses(key)
    for _, input in ipairs(inputs) do
        if input.clicked and not input.max then
            input.text = input.text .. key
        end
    end
end
function Menu:delete(key)
    for _, input in pairs(inputs) do
        if input.clicked and not input.max then
            if key == 'backspace' then
                input.text = input.text:sub(1,-2)
            elseif key == 'return' then
                input.fn()
                input.clicked = false
            end 
        end
    end
end