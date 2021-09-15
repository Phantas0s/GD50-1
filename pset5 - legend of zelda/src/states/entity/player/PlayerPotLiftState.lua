PlayerPotLiftState = Class {__includes = PlayerIdleState}

function PlayerPotLiftState:init(entity, dungeon)
    self.entity = entity
    self.dungeon = dungeon

    self.entity:changeAnimation('pot-lift-' .. self.entity.direction)
end

function PlayerPotLiftState:enter(pot)
    -- reference to the pot for the player
    self.entity.object = pot

    -- defines an onCrash function for the pot
    self.entity.object.onCrash = function (entity)
        -- damage enemy
        gSounds['hit-enemy']:play()
        -- play hit sound
        entity:damage(1)

        -- remove the pot from game after it crashed
        self.entity.object = nil
    end
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerPotLiftState:update(dt)
    local anim = self.entity.currentAnimation
    -- if we've fully elapsed through one cycle of animation, change to pot-idle state
    if anim.currentFrame == #anim.frames then
        anim.currentFrame = 1
        self.entity:changeState('pot-idle')
    end
end