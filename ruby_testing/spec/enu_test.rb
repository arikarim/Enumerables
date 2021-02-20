require_relative '../../enumerables'

# These are tests of Rspect of Enumerables

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'return every value' do
      expect([2, 4].my_each { |x| x }).to eql([2, 4])
    end
    it 'Returns true if contains only nils and false' do
      expect([false, nil].my_none?).to eql(true)
    end
    it 'Returns true if contains only nils and false' do
      expect([true, false, nil].my_none?).to eql(false)
    end
    it 'return true if there are floats' do
      expect([2, 3.14, 432].my_none?(Float)).to eql(false)
    end
    it 'return true if word don t own letter' do
      expect(%w[ant bear car].my_none?(/s/)).to eql(true)
    end
    it 'Returns true if array is empty' do
      expect([].my_none?).to eql(true)
    end
    it 'Returns true if there are only nils' do
      expect([nil].my_none?).to eql(true)
    end
  end

  describe '#my_each_with_index' do
    it 'return enum if no block' do
      arr = [1, 2, 3, 4]
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end

    it 'return array if block' do
      arr = [1, 2, 3, 4]
      expect(
        arr.my_each_with_index do |x, i|
        end
      ).to eql(arr)
    end

    it 'when empty enum no return nil' do
      expect([].my_each_with_index).not_to eql(nil)
    end

    it 'should return the sum of all indexes of the array ' do
      arr = [1, 2, 3, 4]
      total = 0
      arr.my_each_with_index do |_x, i|
        total += i
      end
      expect(total).to eql(6)
    end
  end

  describe '#my_select' do
    it 'Returns just the even numers' do
      expect([1, 2, 3, 4, 5, 6, 7, 8].my_select(&:even?)).to eql([2, 4, 6, 8])
    end
  end

  describe '#my_any?' do
    it 'Returns true if 3 characters or longer' do
      expect(%w[ant bear car].my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it 'Returns true if any inputs are integers' do
      expect([true, nil, 99].my_any?(Integer)).to eql(true)
    end
    it 'Returns false if if has s' do
      expect(%w[ant bear car].my_any?(/s/)).to eql(false)
    end
    it 'Returns false if array is empty' do
      expect([].my_any?).to eql(false)
    end
    it 'Returns true if value of true' do
      expect([nil, true, 99].my_any?).to eql(true)
    end
  end
  it 'Returns true if 4 character or longer' do
    expect(%w[ant bear car].my_any? { |word| word.length >= 4 }).to eql(true)
  end
  describe '#my_none?' do
    it 'Returns false if none of have a lenght greater than or equal to 4' do
      expect(%w[ant bear car].my_none? { |word| word.length >= 4 }).to eql(false)
    end
    it 'Returns true if none have length of 5' do
      expect(%w[ant bear car].my_none? { |word| word.length == 5 }).to eql(true)
    end
  end

  describe '#my_inject' do
    it 'sum of all numbers' do
      expect((1..6).my_inject(:+)).to eql(21)
    end
    it 'multiply all numbers using blocks' do
      expect((5..10).my_inject(1) { |x, n| x * n }).to eql(151_200)
    end
    it 'sum all using block' do
      expect((1..6).my_inject { |x, n| x + n }).to eql(21)
    end
    it 'multiply all numbers' do
      expect((5..10).my_inject(1, :*)).to eql(151_200)
    end
  end

  describe '#my_all?' do
    it 'Returns false as if the words are not greater than or equal to 4' do
      expect(%w[ant bear car].my_all? { |word| word.length >= 4 }).to eql(false)
    end
    it 'Returns true if all inputs are numeric' do
      expect([5, 2i, 32, 124].my_all?(Numeric)).to eql(true)
    end
    it 'Returns false if dont have s' do
      expect(%w[ant bear car].my_all?(/s/)).to eql(false)
    end
    it 'Returns true if the words are greater than or equal to 3' do
      expect(%w[ant bear car].my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'Returns true if all inputs have a value of true' do
      expect([true, nil, 99].my_all?).to eql(false)
    end
    it 'Returns true if array is empty' do
      expect([].my_all?).to eql(true)
    end
  end

  describe '#my_count' do
    it 'Returns the amount of values that are the same as the yield' do
      expect([2, 6, 7].my_count(&:even?)).to eql([2, 6, 7].count(&:even?))
    end
    it 'Returns the amount of values in the array' do
      expect([2, 6, 7].my_count).to eql([2, 6, 7].count)
    end

    it 'Returns the amount of values that are the same as the arg' do
      expect([2, 6, 7].count(2)).to eql([2, 6, 7].count(2))
    end
  end

  describe '#my_map' do
    it 'Returns the array adding the value of the yield' do
      expect([2, 6, 7].my_map { |i| i * i }).to eql([2, 6, 7].map { |i| i * i })
    end
  end

  describe '#multiply_els' do
    it 'Returns the multiplication of all elements like in my_inject' do
      expect(multiply_els([2, 6, 7])).to eql([2, 6, 7].inject { |a, b| a * b })
    end
    it 'get back the largest word' do
      expect(%w[cat sheep bear].my_inject do |memo, word|
               memo.length > word.length ? memo : word
             end).to eql('sheep')
    end
  end
end
