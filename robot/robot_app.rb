require '../console_color'
require './robot'

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
        if @terminator.all_available_methods.include?(string.downcase)
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

RobotApp.run