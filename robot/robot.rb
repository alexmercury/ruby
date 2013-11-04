require '../console_color'

module RobotApp

  extend self

  def run
    console_write 'Booting system from server SkyNet'.green.bold
    @terminator = Robot.new
    command = console_read
    until command.downcase == 'exit'
      try_parse command
      command = console_read
    end
    console_write "I'll be back ...".red.bold
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
          when 4
            test4
          else
            puts "List test:\ntest 1\ntest 2 \ntest 3".green.bold
        end
      else
        puts "List test:\ntest 1\ntest 2 \ntest 3".green.bold
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
    console_write 'Run test 1:'.blue.bold
    console_write 'PLACE 0,0,NORTH'
    @terminator.place(0,0,'NORTH')
    console_write 'MOVE'
    @terminator.move
    console_write 'REPORT'
    @terminator.report
    puts 'Must be: '.blue.bold + '0,1,NORTH'.green
    console_write 'Test 1: '.blue.bold + 'DONE'.green
  end

  def test2
    console_write 'Run test 2:'.blue.bold
    console_write 'PLACE 0,0,NORTH'
    @terminator.place(0,0,'NORTH')
    console_write 'LEFT'
    @terminator.left
    console_write 'REPORT'
    @terminator.report
    puts 'Must be: '.blue.bold + '0,0,WEST'.green
    console_write 'Test 2: '.blue.bold + 'DONE'.green
  end

  def test3
    console_write 'Run test 3:'.blue.bold
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
    puts 'Must be: '.blue.bold + '3,3,NORTH'.green
    console_write 'Test 3: '.blue.bold + 'DONE'.green
  end

  def test4
    console_write 'Run test 3:'.blue.bold
    console_write 'Parse file: '+'test4.txt'.green.bold
    read_from_file('test4.txt').each do |str|
      console_write str.to_s
      try_parse str.to_s
    end
    console_write 'Test 4: '.blue.bold + 'DONE'.green
  end

  def console_write(text)
    puts 'SkyNet:~$ '.bold + text
  end

  def console_read
    print 'SkyNet:~$ '.bold
    gets.chomp
  end

  def read_from_file(full_path)
    all_text = ''
    File.open(full_path, 'r') do |f1|
      while line = f1.gets
        all_text += line
      end
    end
    all_text.to_enum(:scan, /(PLACE \d*,\d*,(WEST|NORTH|EAST|SOUTH))|(MOVE)|(LEFT)|(RIGHT)|(REPORT)/).map{Regexp.last_match}
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
    new_position = @direct.first.last.zip(@position).map{|x, y| x + y}
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
    if stay_on_place?([x,y]) && try_get_direct(f)
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

  def try_do_action(method_name)
    if respond_to?(method_name) && ready?
      send method_name.downcase
    else
      ignore
    end
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
    if pos.include?(-1) || (pos[0] > @table[0]) || (pos[1] > @table[1])
      return false
    else
      return true
    end
  end

end

RobotApp.run