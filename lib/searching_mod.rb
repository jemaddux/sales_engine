module Searching

  def rand(list_of_objects)
    list_of_objects.sample
  end

  def find_by(list_of_objects, attribute, match)
    answer = list_of_objects.select{|instance| instance.send(attribute).match(/^\s?#{(match)}\s?$/i)}
    answer[0]
  end

  def find_all_by(list_of_objects, attribute, match)
    answer = list_of_objects.select{|instance| instance.send(attribute).match(/^\s?#{(match)}\s?$/i)}
  end

end