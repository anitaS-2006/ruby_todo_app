require_relative 'todo' #załadowanie 'todo'
require_relative 'storage' #załadowanie 'storage'

#wczytanie istniejących zadań
todos = Storage.load
#szukanie największego id by nadać nowe
next_id = (todos.map(&:id).max || 0) + 1

#pętla trwająca do momentu wybrania '0'
loop do
    #Menu
  puts "\nTODO LIST:"
  todos.each { |t| puts t }
  puts "\n[1] Dodaj zadanie"
  puts "[2] Oznacz jako zrobione"
  puts "[3] Usuń zadanie"
  puts "[0] Zakończ"

  print "Wybór: "
  case gets.chomp
  when "1"
    #dodawanie zadania
    print "Podaj nazwę zadania: "
    title = gets.chomp
    todos << Todo.new(next_id, title)
    next_id += 1
  when "2"
    #oznaczanie zadania jako zrobione
    print "Podaj ID zadania do oznaczenia: "
    id = gets.chomp.to_i
    todo = todos.find { |t| t.id == id }
    todo.done = true if todo
  when "3"
    #usuwanie zadań
    print "Podaj ID zadania do usunięcia: "
    id = gets.chomp.to_i
    todos.reject! { |t| t.id == id }
  when "0"
    #zakończenie programu i tym samym zapisanie danych do pliku
    Storage.save(todos)
    puts "Do zobaczenia!"
    break
  else
    puts "Nieznana opcja."
  end
end
