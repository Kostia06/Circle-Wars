Settings = {}

--health, speed, max, speed, bullet damage
function Settings:load()
    table.insert(inputs, newInput(
        {screen.w/2, 100},
        {250,64},
        'Player Health',
        function()
            Map:make_client()
        end,
        '100'
    ))
    table.insert(inputs, newInput(
        {screen.w/2, 200},
        {250,64},
        'Player Speed',
        function()
            Map:make_client()
        end,
        '400'
    ))
    table.insert(inputs, newInput(
        {screen.w/2, 300},
        {250,64},
        'Player Max Speed',
        function()
            Map:make_client()
        end,
        '650'
    ))
    table.insert(inputs, newInput(
        {screen.w/2, 400},
        {250,64},
        'Bullet Damage',
        function()
            Map:make_client()
        end,
        '5'
    ))
    table.insert(buttons, newButton(
        {screen.w/2, 500},
        {250,64},
        'Back',
        function()
            Map.menu_state = 'main'
        end
    ))
end

