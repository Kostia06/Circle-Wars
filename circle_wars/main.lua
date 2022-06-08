require 'Manager/menu'
require 'Multi/server'
require 'Multi/client'
require 'Manager/map'
require 'Player/info'
require 'Player/move'
require 'Player/player'
require 'Manager/functions'
require 'Player/bullet'
require 'Player/particle'
require 'Manager/gameover'
require 'Background/dots'
require 'Manager/settings'



dots = {}
screen  ={}
screen.w = love.graphics.getWidth()
screen.h = love.graphics.getHeight()
print = love.graphics.print
rect = love.graphics.rectangle
circle = love.graphics.circle
key = love.keyboard
mouse = love.mouse
font = love.graphics.newFont('fff-forward/FFFFORWA.TTF',15)
event = love.event
clicked = false
wins = 0

function love.load()
    local num = 0
    Map:load()
    while num < 200 do
        table.insert(dots, Dots({0,255,0, 0.5}))
        num = num +1
    end
end

function love.update(dt)
    for _, i in ipairs(dots) do
        i:update(dt)
    end
    Map:update(dt)
    if key.isDown('escape') then
        event.quit(0)
    end
end

function love.draw()
    for _, i in ipairs(dots) do
        i:draw()
    end
    love.graphics.setFont(font)
    Map:draw()
end


function love.mousereleased()
    clicked = false
end