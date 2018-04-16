class Integer
  def perfect?
    divisors = 1.upto(self-1).map {|x| self % x == 0 ? x : nil}.compact
    return divisors.sum == self
  end
end

puts 6.perfect?
puts 28.perfect?
puts 496.perfect?
puts 8128.perfect?

puts 7.perfect?
puts 29.perfect?
puts 497.perfect?
puts 8129.perfect?
