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

end



function Entity:update(dt)
    self.last.x = self.x
    self.last.y = self.y
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

function Entity:resolveCollision(e)
    if self:checkCollision(e) then
        self.x = self.last.x
        self.y = self.last.y
    end
end
