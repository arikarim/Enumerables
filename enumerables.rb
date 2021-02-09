module Enumerable
  def my_each
    length.times { |value| yield(self[value]) }
    self
  end

  def my_each_with_index
    length.times { |value| yield(self[value], value) }
    self
  end

  def my_select
    array = []
    my_each { |num| array << num if yield(num) }
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
control.my_each { |value| print value.to_s + ' ' }
puts
control.my_each_with_index { |value, ind| print ind.to_s + ':' + value.to_s + ' ' }
puts
p(control.my_select { |num| num > 3 })
p(control.my_all? { |i| i < 10 })
p(control.my_any? { |i| i < 5 })
p(control.my_none? { |i| i < 3 })
p control.my_count(2)
p control.my_map(my_proc) #{ |i| i * 2 }
p control.my_inject() { |sum, i| sum + i }
p multiply_els(control) 
