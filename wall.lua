Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "wall.png")

    --seteamos el streng de la wall
    self.strength = 100

    --seteamos el weight en 0 para que no se caigan las paredes a causa de la gravedad.
    self.weight = 0
end