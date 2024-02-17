function love.load()
    Object = require "classic"
    require "entity"
    require "player"
    require "wall"
    require "box"

    player = Player(100, 100)
    box = Box(400,150)

    objects = {}
    table.insert(objects, player)
    table.insert(objects, box)

    map = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
    }

    --por cada tabla(v) en maps...
    for i,v in ipairs(map) do
        --iterá en cada value(w)...
        for j,w in ipairs(v) do
            --y chequeá si es igual a 1.
            if w==1 then
                --si lo es insertá un objeto de tipo Wall en la tabla objects(las posiciones que marca creo que es para que cada wall esté centrada)
                table.insert(objects, Wall((j-1)*50, (i-1)*50))
            end
        end
    end
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

