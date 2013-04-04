module Brandmaker
  class MediaVariable < Variable
    def value
      super.split(",").join("\n")
    end
  end
end
