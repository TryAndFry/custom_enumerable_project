module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  
  def my_each
    return to_enum(:my_each) unless block_given?
    for element in self do
      yield element
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    for element in self do
      yield(element,i)
      i+=1
    end
  end
  
  def my_select()
    return to_enum(:my_select) unless block_given?
    results = []
    my_each {|element|
      results.push(element) if yield element
    }
    results
  end

  def my_all?
    return to_enum(:my_all?) unless block_given?
    my_each {|element|return false unless yield element}
    true
  end

  def my_any?
    my_each {|element| return true if yield element}
    false
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?
    my_each{|element| return false if yield element}
    true
  end

  def my_count
    count = 0;
    if block_given?
      my_each{|element|
        count+=1 if yield element
      }
    else
      count = self.length
    end
    count
  end

  def my_map
    results = []
    my_each{|element| results.push(yield element)}
    results
  end

  def my_inject(init)
    my_each{|element|
      init = yield init,element
    }
    init
  end

end