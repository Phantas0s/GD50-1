--[[
    GD50
    Super Mario Bros. Remake

    -- LevelMaker Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    local entities = {}
    local objects = {}

    local keyX = math.random(10, 70)
    local keyFrame = math.random(4)

    local tileID = TILE_ID_GROUND
    
    -- whether we should draw our tiles with toppers
    local topper = true
    local tileset = math.random(20)
    local topperset = math.random(20)

    -- insert blank tables into tiles for later access
    for x = 1, height do
        table.insert(tiles, {})
    end

    -- column by column generation instead of row; sometimes better for platformers
    for x = 1, width do
        tileID = TILE_ID_EMPTY
        
        -- lay out the empty space
        for y = 1, 6 do
            table.insert(tiles[y],
                Tile(x, y, tileID, nil, tileset, topperset))
        end

        if x < 3 or x > width - 3 then
            -- generate simple ground on the position where the player spawn and at the end of the level
            tileID = TILE_ID_GROUND

            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end
        elseif x == keyX then
            -- random height for our key
            local keyHeight = math.random(4, 6)

            -- generate emptiness or ground randomly
            tileID = math.random(2) == 1 and TILE_ID_EMPTY or TILE_ID_GROUND
            
            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, (y == 7 and tileID == TILE_ID_GROUND) and topper or nil, tileset, topperset))
            end

            if tileID == TILE_ID_GROUND and math.random(8) == 1 then
                -- change key height if on top of a pillar
                keyHeight = math.random(5, 2)

                -- pillar tiles
                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil
            end
            -- add key to the object table
            table.insert(objects,
                GameObject {
                    texture = 'keys-locks',
                    x = (x - 1) * TILE_SIZE,
                    y = (keyHeight - 1) * TILE_SIZE,
                    width = 16,
                    height = 16,
                    -- select random color for the key
                    frame = keyFrame,
                    solid = false,
                    hit = false,
                    collidable = false,
                    consumable = true,
                    onConsume = function (player)
                        gSounds['pickup']:play()
                        
                        -- on consume change the onCollide function of our lock
                        player.level.objects['lock'].onCollide = function ()
                            gSounds['empty-block']:play()
                            table.insert(player.level.objects, 
                                GameObject {
                                    texture = 'poles',
                                    x = (width - 2) * TILE_SIZE,
                                    y = 3 * TILE_SIZE,
                                    width = 16,
                                    height = 48,
                                    -- select random color for the pole
                                    frame = math.random(6),
                                    hit = false,
                                    collidable = true,
                                    onCollide = function ()
                                        -- make the flag move to the base of the pole
                                        Timer.tween(0.8, {
                                            [player.level.objects['flag']] = {y = 5 * TILE_SIZE + 3}
                                        })
                                        -- when done moving wait 0.2 sec and generate a new longer level and keeping track of the score
                                        :finish(function ()
                                            Timer.after(0.2, function ()
                                                gStateMachine:change('play', {
                                                    mapWidth = player.map.width + 10,
                                                    score = player.score
                                                })
                                            end)
                                        end)
                                    end
                                }
                            )
                            -- select random color for the flag
                            local color = math.random(0, 3) * 3

                            player.level.objects['flag'] =
                                GameObject {
                                    texture = 'flags',
                                    x = (width - 1) * TILE_SIZE - 6,
                                    y = 3 * TILE_SIZE,
                                    width = 16,
                                    height = 16,
                                    animation = Animation {
                                        frames = {1 + color, 2 + color, 3 + color},
                                        interval = 0.2
                                    },
                                    solid = false,
                                    hit = false,
                                    collidable = false,
                                    consumable = false,
                                }
                            player.level.objects['lock'] = nil
                        end
                    end
                }
            )
        -- 20 tile from the key we generate our lock
        elseif x == keyX + 20 then

            local blockHeight = 4
            -- generate ground so that we can unlock the block
            tileID = TILE_ID_GROUND
            
            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end
            -- chance of being on top of a pillar
            if math.random(8) == 1 then
                blockHeight = 2

                -- pillar tiles
                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil
            end
            -- lock block
            objects['lock'] = GameObject {
                                texture = 'keys-locks',
                                x = (x - 1) * TILE_SIZE,
                                y = (blockHeight - 1) * TILE_SIZE,
                                width = 16,
                                height = 16,
                                -- make it a random variant
                                frame = keyFrame + 4,
                                hit = false,
                                collidable = true,
                                solid = true,
                                -- empty block sound on collision until we get the key
                                onCollide = function () 
                                    gSounds['empty-block']:play()
                                end
                            }
        elseif math.random(7) == 1 then
            -- chance to just be emptiness
            tileID = TILE_ID_EMPTY
            
            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, nil, tileset, topperset))
            end
        else
            tileID = TILE_ID_GROUND

            -- height at which we would spawn a potential jump block
            local blockHeight = 4

            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end

            -- chance to generate a pillar
            if math.random(8) == 1 then
                blockHeight = 2
                
                -- chance to generate bush on pillar
                if math.random(8) == 1 then
                    table.insert(objects,
                        GameObject {
                            texture = 'bushes',
                            x = (x - 1) * TILE_SIZE,
                            y = (4 - 1) * TILE_SIZE,
                            width = 16,
                            height = 16,
                            
                            -- select random frame from bush_ids whitelist, then random row for variance
                            frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                            collidable = false
                        }
                    )
                end
                
                -- pillar tiles
                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil
            
            -- chance to generate bushes
            elseif math.random(8) == 1 then
                table.insert(objects,
                    GameObject {
                        texture = 'bushes',
                        x = (x - 1) * TILE_SIZE,
                        y = (6 - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,
                        frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                        collidable = false
                    }
                )
            end

            -- chance to spawn a block
            if math.random(10) == 1 then
                table.insert(objects,

                    -- jump block
                    GameObject {
                        texture = 'jump-blocks',
                        x = (x - 1) * TILE_SIZE,
                        y = (blockHeight - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,

                        -- make it a random variant
                        frame = math.random(#JUMP_BLOCKS),
                        collidable = true,
                        hit = false,
                        solid = true,

                        -- collision function takes itself
                        onCollide = function(obj)

                            -- spawn a gem if we haven't already hit the block
                            if not obj.hit then

                                -- chance to spawn gem, not guaranteed
                                if math.random(5) == 1 then

                                    -- maintain reference so we can set it to nil
                                    local gem = GameObject {
                                        texture = 'gems',
                                        x = (x - 1) * TILE_SIZE,
                                        y = (blockHeight - 1) * TILE_SIZE - 4,
                                        width = 16,
                                        height = 16,
                                        frame = math.random(#GEMS),
                                        collidable = true,
                                        consumable = true,
                                        solid = false,

                                        -- gem has its own function to add to the player's score
                                        onConsume = function(player, object)
                                            gSounds['pickup']:play()
                                            player.score = player.score + 100
                                        end
                                    }
                                    
                                    -- make the gem move up from the block and play a sound
                                    Timer.tween(0.1, {
                                        [gem] = {y = (blockHeight - 2) * TILE_SIZE}
                                    })
                                    gSounds['powerup-reveal']:play()

                                    table.insert(objects, gem)
                                end

                                obj.hit = true
                            end

                            gSounds['empty-block']:play()
                        end
                    }
                )
            end
        end
    end

    local map = TileMap(width, height)
    map.tiles = tiles
    
    return GameLevel(entities, objects, map)
end