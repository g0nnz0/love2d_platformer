Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "wall.png")

    --seteamos el streng de la wall
    self.strengh = 100
end