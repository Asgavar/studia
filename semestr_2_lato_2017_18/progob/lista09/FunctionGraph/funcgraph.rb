require "../Function/function.rb"

class Function

  def draw_graph(from, to, x_delta, filename)
    xs = from.step(by: x_delta, to: to)
    arg_val_pairs = xs.map { | x | [x, self.value(x)] }

    open(filename, 'a') { |f|
      f.puts arg_val_pairs.map {
        | pair | pair[0].to_s + "\t" + pair[1].to_s
      }
    }
  end
end

f1 = Function.new(lambda { | x | x })
f1.draw_graph(-10, 10, 1, "wykres1.in")

f2 = Function.new(lambda { | x | x ** 3 })
f2.draw_graph(-10, 10, 1, "wykres2.in")
