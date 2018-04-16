class Integer
  def ack(y)
    if self == 0
      return y + 1
    elsif y == 0
      return (self-1).ack(1)
    else
      (self-1).ack(self.ack(y-1))
    end
  end
end

puts 1.ack(2)  # 4
puts 1.ack(4)  # 6
puts 2.ack(1)  # 5
puts 2.ack(2)  # 7
puts 3.ack(3)  # 61
puts 3.ack(4)  # 125
