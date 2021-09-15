--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelUpMenuState = Class{__includes = BattleMenuState}

function LevelUpMenuState:init(pokemon, onClose)
    -- level up the pokemon and get references to stats
    local HPIncrease, attackIncrease, defenseIncrease, speedIncrease = pokemon:levelUp()

    -- a menu that displays the increased stats 
    self.battleMenu = Menu {
        x = VIRTUAL_WIDTH / 2 - 96,
        y = VIRTUAL_HEIGHT - 64 - 128,
        width = 192,
        height = 128,
        marker = false,
        onClose = onClose,
        items = {
            {
                text = "HP: " .. tostring(pokemon.HP) .. " + " ..tostring(HPIncrease) .. " = "
                    .. tostring(pokemon.HP + HPIncrease)
            },
            {
                text = "Attack: " .. tostring(pokemon.attack) .. " + " .. tostring(attackIncrease) .. " = "
                    ..tostring(pokemon.attack + attackIncrease)
            },
            {
                text = "Defense: " .. tostring(pokemon.defense) .. " + " .. tostring(defenseIncrease) .. " = "
                    .. tostring(pokemon.defense + defenseIncrease)
            },
            {
                text = "Speed: " .. tostring(pokemon.speed) .. " + " .. tostring(speedIncrease) .. " = "
                    .. tostring(pokemon.speed + speedIncrease)
            }
        }
    }
end