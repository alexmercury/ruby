module RobotApp

  extend self

  def run
    console_write colorize('booting system from server SkyNet', 32)
    @terminator = Robot.new
    command = console_read
    until command.downcase == 'exit'
      try_parse command
      command = console_read
    end
    console_write colorize("I'll be back ...\n\tsystem shutdown ...", 31)
  end

  private

  def try_parse(string)
    if string.downcase.include? 'test'
      new_string = /test \d*/.match(string.downcase).to_s
      unless new_string.empty?
        arg = new_string.split(' ')[1]
        case arg.to_i.abs
          when 1
            test1
          when 2
            test2
          when 3
            test3
          else
            puts "List test:\ntest 1\ntest 2 \ntest 3"
        end
      else
        puts "List test:\ntest 1\ntest 2 \ntest 3"
      end
    else
      if string.include? ','
        new_string = /PLACE \d*,\d*,(WEST|NORTH|EAST|SOUTH)/.match(string.upcase).to_s
        unless new_string.empty?
          arg = new_string.split(' ')[1].split(',')
          @terminator.place(arg[0].to_i.abs , arg[1].to_i.abs , arg[2].upcase)
        else
          @terminator.ignore
        end
      else
        if @terminator.ready? &&  @terminator.all_available_methods.include?(string.downcase)
          @terminator.send(string.downcase)
        else
          @terminator.ignore
        end
      end
    end
  end

  def test1
    console_write colorize('Run test 1:', 34)
    console_write 'PLACE 0,0,NORTH'
    @terminator.place(0,0,'NORTH')
    console_write 'MOVE'
    @terminator.move
    console_write 'REPORT'
    @terminator.report
    puts colorize('Must be: ',34) + colorize('0,1,NORTH', 32)
    console_write colorize('Test 1: ', 34) + colorize('DONE', 32)
  end

  def test2
    console_write colorize('Run test 2:', 34)
    console_write 'PLACE 0,0,NORTH'
    @terminator.place(0,0,'NORTH')
    console_write 'LEFT'
    @terminator.left
    console_write 'REPORT'
    @terminator.report
    puts colorize('Must be: ',34) + colorize('0,0,WEST', 32)
    console_write colorize('Test 2: ', 34) + colorize('DONE', 32)
  end

  def test3
    console_write colorize('Run test 3:', 34)
    console_write 'PLACE 1,2,EAST'
    @terminator.place(1,2,'EAST')
    console_write 'MOVE'
    @terminator.move
    console_write 'MOVE'
    @terminator.move
    console_write 'LEFT'
    @terminator.left
    console_write 'MOVE'
    @terminator.move
    console_write 'REPORT'
    @terminator.report
    puts colorize('Must be: ',34) + colorize('3,3,NORTH', 32)
    console_write colorize('Test 3: ', 34) + colorize('DONE', 32)
  end

  #Text style_code:
  #Bold (1)
  #Text color_code:
  # Black (30)
  # Red (31)
  # Green (32)
  # Yellow (33)
  # Blue (34)
  # Magenta (35)
  # Cyan (36)
  # White (37)
  #Background color_code:
  # Red (41)
  # Green (42)
  # Yellow (43)
  # Blue (44)
  # Magenta (45)
  # Cyan (46)
  # White (47)
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

  def console_write(text)
    puts colorize('SkyNet:~$ ', 1) + text
  end

  def console_read
    print colorize('SkyNet:~$ ', 1)
    gets.chomp
  end

end


class Robot

  DIRECTION = [{'NORTH' => [0,1]}, {'EAST' => [1,0]}, {'SOUTH' => [0,-1]}, {'WEST' => [-1,0]}]

  def all_available_methods
    %W[move left right report]
  end

  def initialize(x = 5, y = 6)
    @table = [x,y]
    @direct = nil
  end

  def move
    new_position = get_direct_arr.zip(@position).map{|x, y| x + y}
    stay_on_place?(new_position) ?  @position = new_position : ignore
  end

  def left
    index = DIRECTION.index(@direct)
    index > 0 ? @direct = DIRECTION.at(index - 1) : @direct = DIRECTION.at(DIRECTION.length - 1)
  end

  def right
    index = DIRECTION.index(@direct)
    index < (DIRECTION.length - 1) ? @direct = DIRECTION.at(index + 1) : @direct = DIRECTION.at(0)
  end

  def report
    puts "#{@position[0]},#{@position[1]},#{@direct.first.first}"
  end

  def place(x=0,y=0,f=0)
    if try_get_direct(f) && stay_on_place?([x,y])
      @position = [x,y]
    else
      ignore
    end
  end

  def ignore
    puts 'Ignore you action ...'
  end

  def ready?
    !!@direct
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

  def get_direct_arr
    @direct.first.last
  end

  def arr_sub(arr1, arr2)
    arr1.zip(arr2).map{|x, y|  x + y}
  end

  def stay_on_place?(pos)
    if pos.include?(-1) || pos[0] > @table[0] || pos[1] > @table[1]
      return false
    else
      return true
    end
  end

end

RobotApp.run