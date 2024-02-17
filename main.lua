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
   --mediante un loop llamamos update() en cada objeto de la table objects
    for i,v in ipairs(objects) do 
    v:update(dt)
   end

   --Mediante un loop anidado resolvemos las colisiones
   --en este primer loop recorremos todos los objetos menos el ultimo
   for i=1, #objects-1 do
        --en este loop recorremos los objetos empezando por el que le sigue al primer objeto, y esta vez incluimos al ultimo
        for j=i+1, #objects do
        --de esta manera no estamos llamando resoveCollision() 2 veces por objeto.    
        objects[i]:resolveCollision(objects[j])
        end
    end

end



function love.draw()
    --con otro loop dibujamos todos los objetos
    for i,v in ipairs(objects) do
        v:draw()
    end
   
end

