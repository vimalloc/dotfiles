module DEBUGGER__
  CONFIG[:irb_console] = true

  # Make the ruby debugger gem call a pretty print function that will cause models
  # to be printed mult-line, just just as one string, which is such a stupid default
  class LimitedPP
    def self.pp(obj, max = 80)
      out = self.new(5000)
      catch out do
        PP.pp(obj, out, 80)
      end
      out.buf
    end
  end
end
