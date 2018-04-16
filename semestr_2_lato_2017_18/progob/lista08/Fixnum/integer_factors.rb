class Integer
  def factors
    fs = []
    1.upto(self) do |x|
      if self % x == 0
        fs.push((x))
      end
    end

    return fs
  end
end

$\ = "\n"
print 2138.factors
print 1.factors
print 4.factors
print 97.factors
print 1024.factors
