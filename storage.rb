require_relative 'todo' #załadowanie pliku 'todo.rb'
require 'json' #praca z formatem JSON

module Storage
  FILE = "todos.json"

  #wczytywanie pliku
  def self.load
    return [] unless File.exist?(FILE)

    #odczytanie danych z pliku, zrobienie z nich obiektów 'todo'
    JSON.parse(File.read(FILE)).map do |data|
      Todo.new(data["id"], data["title"], data["done"])
    end
  end

  #zapis do pliku JSOn
  def self.save(todos)
    data = todos.map { |t| { id: t.id, title: t.title, done: t.done } }
    File.write(FILE, JSON.pretty_generate(data))
  end
end
