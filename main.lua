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

    --para mejorar la eficiencia, colocaremos cada wall en una tabla walls, de lo contrario las walls
    --estarian chequeando colisiones entre si lo cual no tiene sentido en este proyecto.
    walls = {}

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

    --por cada tabla(v) en map...
    for i,v in ipairs(map) do
        --iterá en cada value(w) de cada tabla(v)...
        for j,w in ipairs(v) do
            --y chequeá si es igual a 1.
            if w==1 then
                --si lo es insertá un objeto de tipo Wall en la tabla walls(las posiciones que marca creo que es para que cada wall esté centrada)
                table.insert(walls, Wall((j-1)*50, (i-1)*50))
            end
        end
    end
end



function love.update(dt)
   --mediante un loop llamamos update() en cada objeto de la table objects
   for i,v in ipairs(objects) do 
    v:update(dt)
   end

   for i,v in ipairs(walls) do
    v:update(dt)
   end

   --variables locales para controlar el loop en que checkearé si hay colisiones
   local loop = true
   local limit = 0

   --este loop se encarga de chequear constantemente si hay colision
   --seteando un limite para no caer en un bucle infinito.
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

        --mediante otro loop anidado resuelvo las colisiones con las wall
        --por cada wall en walls...
        for i,wall in ipairs(walls) do
            --iterá en cada objeto de objects...
            for i, object in ipairs(objects) do
                --chequea si hay colision con la wall en donde se encuentre...
                local colission = object:resolveCollision(wall)
                if collision then
                    loop = true
                end
            end
        end 
    end

end

function love.keypressed(key)
    if key == "up" then
        player:jump()
    end
end



function love.draw()
    --con otro loop dibujamos el player y la box
    for i,v in ipairs(objects) do
        v:draw()
    end

    --con otro loop dibujamos las paredes
    for i,v in ipairs(walls) do
        v:draw()
    end
   
end

