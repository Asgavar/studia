class Snapshot
  def self.run(format_object, saved_state)
    puts "Obiekty w momencie zapisu:"
    format_object.parse(saved_state).each { |pair|
      puts "Obiekt: #{pair[1]} Klasy: #{pair[0]}"
    }
  end

  def self.save_state(format_object)
    # obiektow w ObjectSpace po samym uruchomieniu interpretera jest tak
    # duzo, ze zdecydowalem sie pomijac ich czesc by zyskac na czytelnosci
    current_index = 0
    objects_to_save = []
    ObjectSpace.each_object { |o|
      unless current_index < 100
        break
      end
      objects_to_save.push(o)
      current_index += 1
    }
    return format_object.save(objects_to_save)
  end
end


class FormatHTML
  def save(objects)
    list_body = objects.map { |o|
      object_to_li(o)
    }.join("\n")
    '<html>' + '<ol>' + list_body + '</ol>' + '</html>'
  end

  def parse(s)
    parsed_pairs = []
    wo_unnecessary_tags = s[9, s.length - 9]
    wo_unnecessary_tags.each_line { |line|
      parsed_pairs.push([
        line.match(/<h3>(.*)<\/h3>/).captures[0],
        line.match(/<\/h3>(.*)<\/li>/).captures[0]
      ])
    }
    parsed_pairs
  end

  def object_to_li(o)
    '<li>' + '<h3>' + o.class.to_s + '</h3>' + o.to_s + '</li>'
  end
end


class FormatTXT
  def save(objects)
    objects.map { |o|
      o.class.to_s + '\t\t\t' + o.to_s
    }.join("\n")
  end

  def parse(s)
    parsed_pairs = []
    s.each_line { |line|
      splitted_line = line.split('\t\t\t')
      parsed_pairs.push([
        splitted_line[0],
        splitted_line[1]
      ])
    }
    parsed_pairs
  end
end


format_txt = FormatTXT.new
format_html = FormatHTML.new

txt_snapshot = Snapshot.save_state(format_txt)
html_snapshot = Snapshot.save_state(format_html)

File.write('txt_format.txt', txt_snapshot)
File.write('html_format.html', html_snapshot)

Snapshot.run(format_txt, txt_snapshot)
Snapshot.run(format_html, html_snapshot)
