Powerup = Class{}

local GRAVITY = 100

function Powerup:init(state, brick)
    self.x = brick.x + brick.width/2 - 8
    self.y = brick.y + brick.height

    self.width = 16
    self.height = 16
    self.state = state
end

function Powerup:update(dt)
    self.y = self.y + GRAVITY * dt
end

function Powerup:collides(target)
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

function Powerup:spawnBalls()
    -- add two balls to a table that we pass in
    for i = 1, 2 do
        local newBall = Ball(math.random(7))
        newBall.x = self.state.paddle.x + (self.state.paddle.width / 2) - 4
        newBall.y = self.state.paddle.y - 8
        newBall.dx = math.random(-200, 200)
        newBall.dy = math.random(-50, -60)
        table.insert(self.state.balls, newBall)
    end
end

function Powerup:render()
    love.graphics.draw(gTextures['main'], gFrames['powerup'], self.x, self.y)
end