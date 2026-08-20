# Make the ruby debugger gem call a pretty print function that will
# cause models to be printed mult-line, just just as one string, which
# is such a stupid default
module DEBUGGER__
  class LimitedPP
    WRAP_WIDTH = 80 # Line length before splitting into newlines

    def self.pp(obj, max = 80)
      max = 5000 if max < 5000 # max line number before truncating (never!!)
      out = self.new(max)
      catch out do
        PP.pp(obj, out, WRAP_WIDTH)
      end
      out.buf
    end
  end
end
