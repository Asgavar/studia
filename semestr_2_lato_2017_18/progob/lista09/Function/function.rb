class Function

  def initialize(funcbody)
    @funcbody = funcbody
  end

  def value(x)
    @funcbody.call(x)
  end

  def root(left, right, epsilon)
    middle = (left + right) / 2
    rightval = self.value(right)
    middleval = self.value(middle)

    if middleval.abs < epsilon
      return middle
    end

    if rightval / rightval.abs != middleval / middleval.abs
      return root(middle, right, epsilon)
    end

    return root(left, middle, epsilon)
  end

  def area(left, right)
    delta = 0.001
    sum = 0

    while left < right
      sum += self.value(left)
      left += delta
    end

    return delta * sum
  end

  def derivative_value(x)
    delta = 0.0001
    return (self.value(x + delta) - self.value(x)) / delta
  end
end


if __FILE__ == $0
  puts "x^3"
  f1 = Function.new(lambda { | x | x ** 3 })
  puts f1.value(3)
  puts f1.root(-100, 100, 0.1)
  puts f1.area(-1/2, 1/2)
  puts f1.derivative_value(2)

  puts "x^2 - 100"
  f2 = Function.new(lambda { | x | x ** 2 - 100 })
  puts f2.value(0)
  puts f2.value(1)
  puts f2.value(10)
  puts f2.root(-20 , 20, 0.5)

  puts "x"
  f3 = Function.new(lambda { | x | x  })
  puts f3.value(91284912)
  puts f3.root(-900, 900, 0.0000001)
end
