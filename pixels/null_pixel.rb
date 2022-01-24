require_relative "pixel"
require 'singleton'
require "colorize"

class NullPixel < Pixel
  include Singleton

  def initialize
    @pos = nil
    @symbol = " "
  end

  def to_s
    "  ".colorize(:green)
  end

end