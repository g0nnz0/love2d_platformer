Entity = Object:extend()

function Entity:new(x, y, image_path)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.last = {}
    self.last.x = self.x
    self.last.y = self.y

    --agregó una propiedad streng para determinar que objeto entre los que colisionan ejerce mas fuerza
    --en este caso el player se quedará con este cero.
    self.strength = 0
    
    --esta fuerza temporal es la que se sumará a la fuerza de la caja para superar a la del player cuando el player empuje la caja contra la pared.
    self.tempStrength = 0

end



function Entity:update(dt)
    self.last.x = self.x
    self.last.y = self.y

    self.tempStrength = self.strength
end


function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


function Entity:checkCollision(e)
    --recordar que esto se lee "si el lado derecho de la entidad está mas a la derecha que el lado izquierdo de e"
    return self.x + self.width > e.x
    --"y si el lado izquierdo de la entidad está mas a la izquierda que el lado derecho de e"
    and self.x < e.x + e.width
    --"y si el lado inferior de la entidad está mas abajo que el lado superior de e"
    and self.y + self.height > e.y
    --"y si el lado superior de la entidad está mas arriba que el lado inferior de e"
    and self.y < e.y + e.height
    --"recien ahi hay colision"
end

--es basicamente el checkCollision() pero en uno apuntando a la alineacion vertical y el otro a la horizontal puntualmente.
function Entity:wasVerticallyAligned(e)
    return self.last.y < e.last.y + e.height and self.last.y + self.height > e.last.y
end


function Entity:wasHorizontallyAligned(e)
    return self.last.x < e.last.x + e.width and self.last.x + self.width > e.last.x
end


function Entity:resolveCollision(e)
    --Ahora antes de chequear las colisiones, chequeamos que objeto ejerce mas fuerza/resistencia
    if self.tempStrength > e.tempStrength then
        --si la fuerza del player fuera mayor a la de la pared, entonces la pared seria la que aplique resolveCollision en el player, siendo movida por el player
        --una vez que chequeamos esto, salimos de la condicion y seguimos con el codigo
        return e:resolveCollision(self)
    end

    if self:checkCollision(e) then

        self.tempStrength = e.tempStrength
        
        if self:wasVerticallyAligned(e) then
            if self.x + self.width/2 < e.x + e.width/2 then
                local pushback = self.x + self.width - e.x
                self.x = self.x - pushback
            else
                local pushback = e.x + e.width - self.x
                self.x = self.x + pushback
            end
        elseif self:wasHorizontallyAligned(e) then
            if self.y + self.height/2 < e.y + e.height/2 then
                local pushback = self.y + self.height - e.y
                self.y = self.y - pushback
            else
                local pushback = e.y + e.height - self.y
                self.y = self.y + pushback
            end
        end
        --hubo colision
        return true

    end
    --de no haber colision return false (tambien podria no retornar nada)
    return false
end
