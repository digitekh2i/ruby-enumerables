# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Style/IfUnlessModifier
module Enumerable
  def my_each
    counter = 0
    while counter < size
      if instance_of(Hash) || instance_of?(Range)
        new_hash = to_a
        yield(new_hash[counter])
      else
        yield(self[counter])
      end
      counter += 1
    end
  end

  def my_each_with_index
    counter = 0
    while counter < size
      if instance_of(Hash) || instance_of?(Range)
        new_hash = to_a
        yield(new_hash[counter], counter)
      else
        yield(self[counter], counter)
      end
      counter += 1
    end
  end

  def my_select
    if instance_of?(Hash)
      new_hash = {}
      my_each { |key, value| new_hash[key] = value if yield(key, value) }
      new_hash
    else
      arr = []
      my_each { |item| arr.push(item) if yield(item) }
      arr
    end
  end

  def my_all?(type = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
    elsif type.nil?
      my_each { |item| return false if item.nil? }
    else
      my_each { |item| return false if item.class != type && item.class.superclass != type }
    end
    true
  end

  def my_any?(type = nil)
    if block_given?
      my_each { |item| return true if yield(item) == true }
    elsif type.nil?
      my_each { |item| return true if item.nil? }
    else
      my_each { |item| return true if item.instance_of?(type.class) || item.class.superclass == type || item.is_a?(type) }
    end
    false
  end

  def my_none?(type = nil)
    if block_given?
      my_each { |item| return false if yield(item) == true }
    elsif type.nil?
      my_each { |item| return false if item.nil? && item != false }
    else
      my_each { |item| return false if item.instance_of?(type) || item.class.superclass == type || item.is_a?(type) }
    end
    true
  end

  def my_count(count = nil)
    counter = 0
    if block_given?
      my_each { |item| counter += 1 if yield(item) == true }
    elsif count.nil?
      my_each { counter += 1 }
    else
      my_each { |item| counter += 1 if item == count }
    end
    counter
  end

  def my_map
    temp_arr = []
    my_each { |item| temp_arr.push(yield(item)) unless yield(item) == false }
    temp_arr
  end

  def my_inject(accum = nil, sym = nil)
    num = nil
    my_each do |item|
      if block_given?
        accum = accum.nil? ? item : yield(accum, item)
      else
        case accum
        when Symbol
          num = num.nil? ? item : num.send(accum, item)
        when Numeric
          accum = accum.send(sym, item)
        end
      end
    end
    num.nil? ? accum : num
  end
end

def multiply_els(arr)
  arr.my_inject { |multiply, item| multiply * item }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Style/IfUnlessModifier
