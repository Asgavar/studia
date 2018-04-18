class Cleartext

  def initialize(text)
    @text = text
  end

  def encrypt(key)
    return Ciphertext.new(@text.chars.map { |c| key[c] }.join(''))
  end

  def to_s
    return @text
  end
end


class Ciphertext

  def initialize(text)
    @text = text
  end

  def decrypt(key)
    rkey = key.invert
    return Cleartext.new(@text.chars.map { |c| rkey[c] }.join(''))
  end

  def to_s
    return @text
  end
end


$\ = "\n"

a_key = {
  'a' => 'x',
  'b' => 'y',
  'c' => 'z',
  'd' => 'w'
}

a = Cleartext.new('abcd')
a_encrypted = a.encrypt(a_key)
a_decrypted = a_encrypted.decrypt(a_key)

print a.to_s
print a_encrypted.to_s
print a_decrypted.to_s

b_key = {
  'r' => 'y',
  'u' => 'a',
  'b' => 'r',
  'y' => 'u'
}

b = Cleartext.new('ruby')
b_encrypted = b.encrypt(b_key)
b_decrypted = b_encrypted.decrypt(b_key)

print b.to_s
print b_encrypted.to_s
print b_decrypted.to_s
