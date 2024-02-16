Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "wall.png")

    --seteamos el streng de la wall
    self.strength = 100
end