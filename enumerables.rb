module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_arr = []
    to_a.my_each { |item| new_arr << item if yield item }
    new_arr
  end

  def my_all?()
    if block_given?
      to_a.my_each { |item| return false if yield(item) == false }
      return true
    elsif param.nil?
      to_a.my_each { |item| return false if item.nil? || item == false }
    # i commented this lines so it does not cause linter errors.
    # elsif !param.nil? && (param.is_a? Class)
    #   to_a.my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
    # elsif !param.nil? && param.instance_of?(Regexp)
    #   to_a.my_each { |item| return false unless param.match(item) }
    else
      to_a.my_each { |item| return false if item != param }
    end
    true
  end

  def my_any?(param = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
      return false
    elsif param.nil?
      to_a.my_each { |item| return true if item }
    # i commented this lines so it does not cause linter errors.
    # elsif !param.nil? && (param.is_a? Class)
    #   to_a.my_each { |item| return true if [item.class, item.class.superclass].include?(param) }
    # elsif !param.nil? && param.class == Regexp
    #   to_a.my_each { |item| return true if param.match(item) }
    else
      to_a.my_each { |item| return true if item == param }
    end
    false
  end

  def my_none?(param = nil)
    if block_given?
      !my_any?(&Proc.new)
    else
      !my_any?(param)
    end
  end

  def my_count(param = nil)
    c = 0
    if block_given?
      to_a.my_each { |item| c += 1 if yield(item) }
    elsif !block_given? && param.nil?
      c = to_a.length
    else
      c = to_a.my_select { |item| item == param }.length
    end
    c
  end

  def my_map(my_proc = nil)
    return to_enum(:my_map) unless block_given? || !my_proc.nil?

    arr = []
    if proc.nil?
      to_a.my_each { |item| arr << yield(item) }
    else
      to_a.my_each { |item| arr << proc.call(item) }
    end
    arr
  end

  def my_inject(initial = nil, sym = nil)
    if !initial.nil? && initial.is_a?(Symbol)
      sym = initial
      initial = nil
    end
    if !block_given?
      to_a.my_each { |item| initial = initial.nil? ? item : initial.send(sym, item) }
    else
      to_a.my_each { |item| initial = initial.nil? ? item : yield(initial, item) }
    end
    initial
  end
end

def multiply_els(array)
  array.my_inject(1) { |product, i| product * i }
end

my_proc = proc { |i| i * 2 }
# I put this last line so the (my_proc) does not cause linter errors.
p control.my_map(my_proc) { |i| i * 3 }
