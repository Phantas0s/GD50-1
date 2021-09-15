--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        type = 'tiles',
        texture = 'tiles',
        frame = 14,
        width = 16,
        height = 16,
        solid = true,
        scale = 1,
        defaultState = 'base',
        states = {
            ['base'] = {}
        }
    },
    ['heart'] = {
        type = 'hearts',
        texture = 'hearts',
        frame = 5,
        width = 16,
        height = 16,
        solid = false,
        scale = 0.7,
        consumable = true,
        defaultState = 'base',
        states = {
            ['base'] = {}
        }
    }
}