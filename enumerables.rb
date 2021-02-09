module Enumerable
  def my_each
    length.times { |i| yield(self[i]) }
    self
  end

  def my_each_with_index
    length.times { |i| yield(self[i], i) }
    self
  end

  # def my_select   ### WITHOUTH MY_EACH
  #   array = []
  #   self.length.times { |i| yield(self[i]) && array.push(self[i]) }
  #   array
  # end

  def my_select
    array = []
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?
    result = true
    my_each { |i| break result = false unless yield(i) }
    result
  end

  def my_any?
    result = false
    my_each { |i| break result = true if yield(i) }
    result
  end

  def my_none?
    result = true
    my_each { |i| break result = false if yield(i) }
    result
  end

  def my_count(arg)
    counter = 0
    my_each { |i| counter += 1 if arg == i }
    counter
  end

  def my_map(proc = nil)
    array = []
    block_given? ? my_each { |i| array << yield(i) } : my_each { |i| array << proc.call(i) }
    array
  end

  def my_inject(accumulator = 0)
    my_each { |i| accumulator = yield(accumulator, i) }
    accumulator
  end
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end

my_proc = proc { |i| i * 2 }

puts
control = [1, 2, 8, 5, 5]
puts "control array = #{control}"
puts
control.my_each { |i| print i.to_s + ' ' }
puts
control.my_each_with_index { |i, ind| print ind.to_s + ':' + i.to_s + ' ' }
puts
p(control.my_select { |i| i < 3 })
p(control.my_all? { |i| i < 3 })
p(control.my_any? { |i| i < 3 })
p(control.my_none? { |i| i < 3 })
p control.my_count(2)
p control.my_map(my_proc) { |i| i * 2 }
p control.my_inject(10) { |sum, i| sum + i }
p multiply_els(control)
