function love.load()
    Object = require "classic"
    require "entity"
    require "player"
    require "wall"
    require "box"

    player = Player(100, 100)
    wall = Wall(200, 100)
    box = Box(400,150)

    objects = {}
    table.insert(objects, player)
    table.insert(objects, wall)
    table.insert(objects, box)
end



function love.update(dt)
    player:update(dt)
    wall:update(dt)
   

    player:resolveCollision(wall)
end



function love.draw()
    player:draw()
    wall:draw()
   
end

