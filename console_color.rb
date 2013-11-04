class String

  def bold
    colorize self, 1
  end

  def red
    colorize self, 31
  end

  def black
    colorize self, 30
  end

  def green
    colorize self, 32
  end

  def yellow
    colorize self, 33
  end

  def blue
    colorize self, 34
  end

  def magenta
    colorize self, 35
  end

  def cyan
    colorize self, 36
  end

  def white
    colorize self, 37
  end

  def bkg_red
    colorize self, 41
  end

  def bkg_green
    colorize self, 42
  end

  def bkg_yellow
    colorize self, 43
  end

  def bkg_blue
    colorize self, 44
  end

  def bkg_magenta
    colorize self, 45
  end

  def bkg_cyan
    colorize self, 46
  end

  def bkg_white
    colorize self, 47
  end

  private
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

end