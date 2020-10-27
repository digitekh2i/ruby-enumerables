module Enumerable 
  def my_each
    counter = 0
    while counter < self.size
      if self.class == Hash || self.instance_of?(Range)
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
        self.my_each { |key, value| new_hash[key] = value if yield(key, value) }
          new_hash
      else
        arr = []
        self.my_each { |item| arr.push(item) if yield(item) }
        arr
      end  
  end

  def my_all?(type = nil)
    if block_given?
      self.my_each { |item| return false if yield(item) == false }
    elsif type.nil?
      self.my_each { |item| return false if item.nil? }
    else
      self.my_each {|item| return false if item.class != type && item.class.superclass != type}
    end
    true
  end

 def my_any?(test = nil)
  if block_given?
    self.my_each { |item| return true if yield(item) == true }
  elsif test.nil?
    self.my_each { |item| return true if item.nil? }
  else
    self.my_each {|item| return true if item.class == test || item.class.superclass == test || item.is_a? test}
  end
    false
 end

 def my_none?(type = nil)
    if block_given?
      self.my_each { |item| return false if yield(item) == true }
    elsif test.nil?
      self.my_each { |item| return false if item.nil? and item != false }
    else
      self.my_each {|item| return false if item.class == test || item.class.superclass == test || item.is_a? test}
    end
    true
  end

end
