class Point

  attr_accessor :x, :y

  def initialize(x,y)
    @x = x
    @y = y
  end

  def addition!(point)
    @x += point.x
    @y += point.y
  end

  def addition(point)
    Point.new(@x + point.x, @y + point.y)
  end

end