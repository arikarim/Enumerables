require_relative 'enumerables'

describe Enumerable do
    describe '#my_each' do
        it 'return true if the array is empty' do
            expect(my_each([])).to eql(true)
        end
    end
end