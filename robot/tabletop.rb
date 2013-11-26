class Tabletop

  def initialize(height, width)
    @size = { :height => height, :width => width}
  end

  def includes_point?(point)
    point.x >= 0 && point.y >= 0 && point.y <= @size[:height] && point.x <= @size[:width]
  end

end