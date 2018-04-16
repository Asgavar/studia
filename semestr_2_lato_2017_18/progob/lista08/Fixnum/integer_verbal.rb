# coding: utf-8

class Integer

  @@words = {
    0 => "zero",
    1 => "jeden",
    2 => "dwa",
    3 => "trzy",
    4 => "cztery",
    5 => "pięć",
    6 => "sześć",
    7 => "siedem",
    8 => "osiem",
    9 => "dziewięć",
  }

  def verbal
    return self.to_s.chars.map { |digit| @@words[digit.to_i] }.join(", ")
  end
end

puts 1234.verbal
puts 11.verbal
puts 99999.verbal
puts 42.verbal
