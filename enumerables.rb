module Enumerable
  # loop over array
  def my_each
    # If no block is given, an Enumerator is returned.
    return enum_for unless block_given?

    # Convert range to array so can use length.
    list = is_a?(Range) ? to_a : self

    count = 0
    while count < list.length
      yield(list[count])
      count += 1
    end
    # Explicity return otherwise nil
    list
  end

  # Loop over elements an index of an array.
  def my_each_with_index
    return enum_for unless block_given?

    list = is_a?(Range) ? to_a : self

    count = 0
    while count < list.length
      yield(self[count], count)
      count += 1
    end
    list
  end

  # FILTER - return elements which match block condition.
  def my_select
    # again since my_each only trigger when have block
    return enum_for unless block_given?

    filter = []
    my_each { |element| filter.push(element) if yield(element) }
    filter
  end

  # Check if all array elements match the given condition.
  def my_all?(*args)
    lever = true
    # given class as arg, check if all elements belong to same class
    if !args[0].nil?
      my_each { |element| lever = false unless args[0] == element }
    elsif !block_given?
      my_each { |element| lever = false unless element }
    # given block
    # Rubocop issue, else can allow unexpect edge case pass
    else
      my_each { |element| lever = false unless yield(element) }
    end
    lever
  end

  # true if at least one element match condition.
  def my_any?(*arg)
    lever = false
    if !arg[0].nil?
      # Rubocop CaseEquality false, because explicity one case
      # for every single class is not reasonable
      my_each { |element| lever = true if arg[0] == element }
    elsif !block_given?
      my_each { |element| lever = true if element }
    else
      my_each { |element| lever = true if yield(element) }
    end
    lever
  end

  # Check if there is no one element with given conditions.
  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  # Count elements in object, allow one argument.
  def my_count(num = nil)
    count = 0

    # has arg
    if num
      my_each { |element| count += 1 if element == num }

    # don't have block
    elsif !block_given?
      count = length

    # don't have arg
    elsif !num
      my_each { |element| count += 1 if yield element }
    end
    count
  end

  # MAP like
  def my_map(proc_x = nil)
    return enum_for unless block_given?

    map_list = []
    if proc_x.nil?
      my_each { |element| map_list.push(yield(element)) }
    else
      my_each { |element| map_list.push(proc_x.call(element)) }
    end
    map_list
  end

  # REDUCE like
  # Cyclomatic Complexity is just one point above [7/6],
  # And it's already reduce the maximum I can, without split method.
  # rubocop:disable Metrics/CyclomaticComplexity
  def my_inject(*args)
    list = is_a?(Range) ? to_a : self

    reduce = args[0] if args[0].is_a?(Integer)
    operator = args[0].is_a?(Symbol) ? args[0] : args[1]

    if operator
      list.my_each { |item| reduce = reduce ? reduce.send(operator, item) : item }
      return reduce
    end
    list.my_each { |item| reduce = reduce ? yield(reduce, item) : item }
    reduce
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # Method to test my_inject.

  def multiply_els(list)
    list.my_inject(:*)
  end
  # rubocop enable Style/CaseEquality
end

p 'xamples'
p(%w[a b c].my_each { |x| print x, ' -- ' })
p(1..3).my_each { |x| print x, ' -- ' }
p(%w[A B C].my_each_with_index { |val, index| puts "Element #{val} is on index #{index}" })
p [1, 2, 3, 4, 5].my_select(&:even?)
p [nil, true, 99].my_all?
p [nil, true, 99].my_any?
p [nil, false].my_none?
p [1, 2, 4, 2].my_count(2)
proc2 = proc { |x| x**3 }
p [1, 2, 3, 4].map(&proc2)
p(5..10).my_inject(:*) # 151200
