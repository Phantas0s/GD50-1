--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local BRONZE_TROPHY = love.graphics.newImage('BronzeTrophy.png')
local SILVER_TROPHY = love.graphics.newImage('SilverTrophy.png')
local GOLD_TROPHY = love.graphics.newImage('GoldTrophy.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:drawTrophy()
    local x = VIRTUAL_WIDTH / 2 - GOLD_TROPHY:getWidth() / 2

    if self.score > 5 then
        love.graphics.draw(GOLD_TROPHY, x, 130)
    elseif self.score >= 3 then
        love.graphics.draw(SILVER_TROPHY, x, 130)
    else
        love.graphics.draw(BRONZE_TROPHY, x, 130)
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')

    -- displays the correct trophy according to the score
    self:drawTrophy()
end