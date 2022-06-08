Dots = {}

function Dots(color)
    return{
        x = love.math.random(0, screen.w),
        y = love.math.random(0, screen.h),
        size = love.math.random(1,3),
        dir_x = love.math.random(-2,2),
        dir_y = love.math.random(-2,2),
        timer = 0,
        speed = 15,
        color =color,
        turn = 1,
        update = function(self, dt)
            self.x = self.x + (self.dir_x *dt*self.speed ) 
            self.y = self.y + (self.dir_y *dt*self.speed )
            if self.x < 0 or self.x > screen.w then
                self.dir_x = self.dir_x * -1
            end
            if self.y < 0 or self.y > screen.h then
                self.dir_y = self.dir_y * -1
            end

        end,
        draw = function(self)
            local list  = {}
            setColor(self.color)
            circle('fill', self.x, self.y, self.size)


            local mouse_x, mouse_y = mouse.getPosition()
            setColor({0,0,0})
            circle('fill', mouse_x, mouse_y, 100)
        end,
    }
end