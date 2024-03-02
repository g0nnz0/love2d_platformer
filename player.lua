Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "player.png")
    self.strength = 10

    self.canJump = false
end


function Player:update(dt)
    Player.super.update(self, dt)

    if love.keyboard.isDown("left") then
        self.x = self.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + 200 * dt
    end

    --esta condicion soluciona el bug de que si me dejaba caer desde una superficie podia saltar en el aire.
    if self.last.y ~= self.y then
        self.canJump = false
    end
    

end

function Player:jump()
    if self.canJump then
    self.gravity = -300
    self.canJump = false
    end
end

--sobreescrbimos la function collide para poder setear el canjump en true
function Player:collide(e, direction)
    Player.super.collide(self, e, direction)
    if direction == "bottom" then
        self.canJump = true
    end
end