--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety, shiny)

    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety

    -- shiny flag
    self.shiny = shiny or false

    if self.shiny then
        self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)
        self.psystem:setParticleLifetime(0.5, 1)
        self.psystem:setLinearAcceleration(-15, 0, 15, 80)
        self.psystem:setEmissionArea('normal', 8, 8)
        self.psystem:setColors({255, 215, 0, 255}, {255, 215, 0, 0})
        self.psystem:setEmissionRate(50)
        self.psystem:setSizes(0.5)
        self.psystem:start()
    end
end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34, 32, 52, 255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)
end

function Tile:renderParticles(x, y)
    love.graphics.draw(self.psystem, self.x + x + 16, self.y + y + 16)
end