# spec/main_spec.rb
require 'stringio'
require_relative '../main'
require_relative '../todo'
require_relative '../storage'

RSpec.describe "Main TODO app" do
  let(:todo1) { Todo.new(1, "Test 1") }
  let(:todo2) { Todo.new(2, "Test 2") }

  before do
    allow(Storage).to receive(:load).and_return([todo1.dup, todo2.dup])
    allow(Storage).to receive(:save)
  end

  def run_with_input(*inputs)
    input = StringIO.new(inputs.join("\n") + "\n")
    output = StringIO.new
    $stdin = input
    $stdout = output
    begin
      load File.expand_path("../main.rb", __FILE__)
    rescue SystemExit
    ensure
      $stdin = STDIN
      $stdout = STDOUT
    end
    output.string
  end

  it "shows todos and exits" do
    output = run_with_input("0")
    expect(output).to include("TODO LIST:")
    expect(output).to include("Test 1")
    expect(output).to include("Test 2")
    expect(output).to include("Do zobaczenia!")
  end

  it "adds a new todo" do
    allow(Storage).to receive(:save)
    output = run_with_input("1", "Nowe zadanie", "0")
    expect(output).to include("Podaj nazwę zadania:")
    expect(Storage).to have_received(:save)
  end

  it "marks a todo as done" do
    allow(Storage).to receive(:save)
    output = run_with_input("2", "1", "0")
    expect(output).to include("Podaj ID zadania do oznaczenia:")
    expect(Storage).to have_received(:save)
  end

  it "removes a todo" do
    allow(Storage).to receive(:save)
    output = run_with_input("3", "1", "0")
    expect(output).to include("Podaj ID zadania do usunięcia:")
    expect(Storage).to have_received(:save)
  end

  it "handles unknown option" do
    output = run_with_input("9", "0")
    expect(output).to include("Nieznana opcja.")
  end
end