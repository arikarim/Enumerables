possibles = []
last = 0
arrr = keyboards.product(drives).map { |x, y| x + y }
arrr.map do |x|
  x <= b ? possibles.push(x) : x
  last = possibles.max
  last
end
possibles.empty? ? -1 : last

a = [4, 6, 5, 3, 3, 1]
n = [4, 6, 5, 3, 3, 1]
count = 0
arr = []
a.product(n).map do |x, y|
  x - y == 0 || x - y == 1 ? arr.push(x) : arr
  arr
end

puts 'result'
puts arr
# count = 0
# n.map do |x|
#   if x - a.map == 0 || x - a.map == 1
#     count += 1
#   end
# end

# puts count
