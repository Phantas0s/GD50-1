--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerPotIdleState = Class {__includes = PlayerIdleState}

function PlayerPotIdleState:init(entity, dungeon)
    self.entity = entity
    self.dungeon = dungeon

    self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
end

function PlayerPotIdleState:update(dt)
    local pot = self.entity.object

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('pot-walk')
    end
    -- if return is pressed the pot is thrown in the direction the player is facing
    -- and if it collides with an entity it deals damage and disappears
    -- the pot also disappears if it hits a wall
    if love.keyboard.wasPressed('return') then
        local y = pot.y
        local x = pot.x

        if self.entity.direction == 'up' then
            pot.update = function (pot, dt)
                pot.y = pot.y - 100 * dt
                for k, entity in pairs(pot.entities) do
                    if entity:collides(pot) then
                        pot.onCrash(entity)
                        break
                    end
                end

                if pot.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE or pot.y < y - TILE_SIZE * 4 then
                    -- remove the pot from game after it crashed
                    self.entity.object = nil
                end
            end
        elseif self.entity.direction == 'right' then
            pot.update = function (pot, dt)
                pot.x = pot.x + 100 * dt
                for k, entity in pairs(pot.entities) do
                    if entity:collides(pot) then
                        pot.onCrash(entity)
                        break
                    end
                end

                if pot.x + pot.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 or pot.x > x + TILE_SIZE * 4 then
                    -- remove the pot from game after it crashed
                    self.entity.object = nil
                end
            end
        elseif self.entity.direction == 'down' then
            pot.update = function (pot, dt)
                pot.y = pot.y + 100 * dt
                for k, entity in pairs(pot.entities) do
                    if entity:collides(pot) then
                        pot.onCrash(entity)
                        break
                    end
                end

                if pot.y >= VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
                + MAP_RENDER_OFFSET_Y - TILE_SIZE or pot.y > y + TILE_SIZE * 4 then
                    -- remove the pot from game after it crashed
                    self.entity.object = nil
                end
            end
        elseif self.entity.direction == 'left' then
            pot.update = function (pot, dt)
                pot.x = pot.x - 100 * dt
                for k, entity in pairs(pot.entities) do
                    if entity:collides(pot) then
                        pot.onCrash(entity)
                        break
                    end
                end

                if pot.x <= MAP_RENDER_OFFSET_X + TILE_SIZE or pot.x < x - TILE_SIZE * 4 then
                    -- remove the pot from game after it crashed
                    self.entity.object = nil
                end
            end
        end
        self.entity:changeState('idle')
    end
end