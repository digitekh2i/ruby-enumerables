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
  
    def my_each_with_index
      counter = 0
      while counter < self.size
        if self == Hash || self == Range
          new_hash = self.to_a
          yield(new_hash[counter], counter)
        else 
          yield(self[counter], counter)
        end
        counter += 1
      end
    end
    
    def my_select
        if self == Hash 
          new_hash = {}
          self.my_each{ |key, value| if yield(key, value) do new_hash[key]= value}
            new_hash
        else
          arr = []
          self.my_each { |item| if yield(item) do arr.push(item)}
          arr
        end  
    end
  end