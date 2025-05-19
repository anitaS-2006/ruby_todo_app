#kod pojedynczego zadania
class Todo
  attr_accessor :id, :title, :done

  #konstruktor do nowego zadania
  def initialize(id, title, done = false)
    @id = id
    @title = title
    @done = done
  end

  def to_s
    #oznaczenie czy zadanie jest zrobione
    status = done ? "[x]" : "[ ]"
    "#{status} #{id}: #{title}" #wyświetlenie napisu
  end
end
