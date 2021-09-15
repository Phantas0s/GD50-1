Key = Class{}

local GRAVITY = 100

function Key:init(state, brick)
    self.x = brick.x + brick.width/2 - 8
    self.y = brick.y + brick.height

    self.width = 16
    self.height = 16
    self.state = state

    self.collected = false
end

function Key:update(dt)
    if not self.collected then
        self.y = self.y + GRAVITY * dt
    end
end

function Key:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function Key:render()
    love.graphics.draw(gTextures['main'], gFrames['key'], self.x, self.y)
end