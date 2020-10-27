
module Enumerable 
    def my_each
      counter = 0
      while counter < self.size
        if self == Hash
          new_hash = self.to_a
          yield(new_hash[counter])
        else 
         yield(self[counter])
        end
        counter += 1
      end
    end
  end