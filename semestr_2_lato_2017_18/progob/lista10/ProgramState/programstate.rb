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
      unless current_index < 10
        break
      end
      objects_to_save.push(o)
    }
    return format_object.save(objects_to_save)
  end
end


class FormatHTML
  def save(objects)
    list_body = objects.map { |o|
      object_to_li(o)
    }.join("\n")
    "<html>" + "<ol>" + list_body + "</ol>" + "</html>"
  end

  def parse(s)
    parsed_pairs = []
    wo_unnecessary_tags = s[9, s.length - 9]
    wo_unnecessary_tags.each_line { |line|
      puts line
      parsed_pairs.push([
        #line.match(/<h3>(.*)<\/h3>/),
        line.match(/<h3>(.*)<\/h3>/).captures[0],
        #line.match(/<\/h3>(.*)<\/li>/),
        line.match(/<\/h3>(.*)<\/li>/).captures[0]
      ])
    }
    return parsed_pairs
  end

  def object_to_li(o)
    "<li>" + "<h3>" + o.class.to_s + "</h3>" + o.to_s.tr('\r\n', '') + "</li>"
  end
end


class FormatTXT
  def save(objects)
    objects.map { |o|
      o.class.to_s + " " + o.to_s
    }
  end

  def parse(s)
    s
  end
end


format_html = FormatHTML.new
#format_txt = FormatTXT.new

html_snapshot = Snapshot.save_state(format_html)
#txt_snapshot = Snapshot.save_state(format_txt)

Snapshot.run(format_html, html_snapshot)
#txt_parsed = Snapshot.run(format_txt, txt_snapshot)

#puts "HTML: #{html_parsed}"
#puts "TXT: #{txt_parsed}"
