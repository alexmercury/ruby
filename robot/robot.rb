require './point'
require './tabletop'

class Robot

  DIRECTION = [
      {'NORTH' => Point.new(0,1)},
      {'EAST' => Point.new(1,0)},
      {'SOUTH' => Point.new(0,-1)},
      {'WEST' => Point.new(-1,0)}
  ]

  def all_available_methods
    %W[move left right report]
  end

  def initialize(height = 5, width = 6)
    @table = Tabletop.new(height, width)
    @position = nil
    @direct = nil
  end

  def move
    (ready? && @table.includes_point?(@position.addition(@direct.values.first))) ? @position.addition!(@direct.values.first) : ignore
  end

  def left
    ready? ? rotate(-1) : ignore
  end

  def right
    ready? ? rotate(1) : ignore
  end

  def report
    ready? ? (puts "#{@position.x},#{@position.y},#{@direct.keys.first}") : ignore
  end

  def place(x=0,y=0,f=0)
    @position = Point.new(x,y)
    ignore unless (@table.includes_point?(@position) && try_get_direct(f))
  end

  def ignore
    puts 'Ignore you action ...'
  end

  private
  def try_get_direct(f)
    dir = DIRECTION.select{|x| x.key? f}
    if dir.length == 1
      @direct = dir[0]
      return true
    else
      return false
    end
  end

  def ready?
    !!@direct
  end

  def rotate(flag)
    @direct = DIRECTION.at((DIRECTION.index(@direct) + flag) % DIRECTION.length)
  end

end