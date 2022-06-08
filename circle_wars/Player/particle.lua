Particle = {}
particle_list ={}
function Particle:new(x,y, name)
    local p = {}
	self.__index = self
	p.x = x
	p.y = y
	p.size = 30
	p.alpha = 1
    p.name = name
    return setmetatable(p, Particle)
end

function Particle:draw(color)
    love.graphics.setColor(color[1], color[2], color[3],self.alpha)
    circle('line', self.x, self.y, self.size)
end
function Particle:update()
    self.alpha = self.alpha - 0.05
end


