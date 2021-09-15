--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)

    if self.object then
        self.object:update(dt)
    end
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:solidCollision(object)
    if self.direction == 'left' then
        if not ((self.y + self.height / 2 >= object.y + object.height) or (self.y + self.height <= object.y)) then
            self.x = object.x + object.width
        end
    elseif self.direction == 'right' then
        if not ((self.y + self.height / 2 >= object.y + object.height) or (self.y + self.height <= object.y)) then
            self.x = object.x - self.width
        end
    elseif self.direction == 'up' then
        if not ((self.x >= object.x + object.width) or (self.x + self.width <= object.x)) then
            self.y = object.y + object.height - self.height / 2 --
        end
    elseif self.direction == 'down' then
        if not ((self.x >= object.x + object.width) or (self.x + self.width <= object.x)) then
            self.y = object.y - self.height
        end
    end
end

function Player:render()
    Entity.render(self)

    if self.object then
        self.object:render()
    end
    
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end