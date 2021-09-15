PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    -- saves current game state (bird, pipes, score and timer)
    self.bird = params.bird
    self.pipePairs = params.pipes
    self.score = params.score
    self.timer = params.timer

    -- pause music and play pause sound
    sounds['music']:pause()
    sounds['pause']:play()

    -- stop scrolling
    scrolling = false
end

function PauseState:update(dt)
    -- if we unpause we go back to the play state
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play', {
            bird = self.bird,
            score = self.score,
            pipes = self.pipePairs,
            timer = self.timer
        })
    end
end

function PauseState:exit()
    -- scrolling resume
    scrolling = true
    -- music resume
    sounds['music']:play()
end

function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    love.graphics.printf('Pause', flappyFont, 0, VIRTUAL_HEIGHT / 2 - 28, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press P to resume', mediumFont, 0, VIRTUAL_HEIGHT / 2 + 10, VIRTUAL_WIDTH, 'center')
end