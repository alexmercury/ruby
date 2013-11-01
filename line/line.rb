module Line

  def self.overlap(first = [], second = [])

    first.sort!
    second.sort!

    range = (first + second).sort

    both = []; range1 = []; range2 = []

    both << range[1] << range[2] unless range[1] == first[1] || range[1] == second[1]

    if range[2] == first[0] || range[2] == second[0]
      range1 = first
      range2 = second
    else
      range1 = both.zip(first).map{|x,y| [x,y].sort! if x != y}.reject{|item| item.nil?}
      range2 = both.zip(second).map{|x,y| [x,y].sort! if x != y}.reject{|item| item.nil?}
    end

    {:range1 => range1, :both => both, :range2 => range2}
  end

end

puts Line.overlap([-1,-100], [-50,0])
puts Line.overlap([1,10], [5,20])