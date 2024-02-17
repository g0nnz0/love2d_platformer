function love.load()
    Object = require "classic"
    require "entity"
    require "player"
    require "wall"
    require "box"

    player = Player(100, 100)
    wall = Wall(200, 100)
    box2 = Box(500, 100)
    box3 = Box(600, 100)
    box = Box(400,150)

    objects = {}
    table.insert(objects, player)
    table.insert(objects, wall)
    table.insert(objects, box2)
    table.insert(objects, box3)
    table.insert(objects, box)
end



function love.update(dt)
   --mediante un loop llamamos update() en cada objeto de la table objects
    for i,v in ipairs(objects) do 
    v:update(dt)
   end

   --variables locales para controlar el loop en que checkearé si hay colisiones
   local loop = true
   local limit = 0

   --este loop se encarga de chequear constantemente si hay colision
   --setenado un limite para no caer en un bucle infinito.
   while loop do
    
        loop = false
        limit = limit + 1

        if limit > 100 then
            break
        end

   --Mediante un loop anidado resolvemos las colisiones
   --en este primer loop recorremos todos los objetos menos el ultimo
        for i=1, #objects-1 do
        --en este loop recorremos los objetos empezando por el que le sigue al primer objeto, y esta vez incluimos al ultimo
                for j=i+1, #objects do
        --de esta manera no estamos llamando resoveCollision() 2 veces por objeto.    
                    local collision = objects[i]:resolveCollision(objects[j])
                   if collision then
                        loop = true
                   end
                end
        end
    end

end



function love.draw()
    --con otro loop dibujamos todos los objetos
    for i,v in ipairs(objects) do
        v:draw()
    end
   
end

