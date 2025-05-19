require 'minitest/autorun'
require_relative 'todo'

class TodoTest < Minitest::Test
  def setup
    @todo = Todo.new(1, "Test task")
  end

  def test_initialize_defaults
    assert_equal 1, @todo.id
    assert_equal "Test task", @todo.title
    assert_equal false, @todo.done
  end

  def test_initialize_with_done_true
    todo = Todo.new(2, "Done task", true)
    assert_equal true, todo.done
  end

  def test_to_s_not_done
    expected = "[ ] 1: Test task"
    assert_equal expected, @todo.to_s
  end

  def test_to_s_done
    @todo.done = true
    expected = "[x] 1: Test task"
    assert_equal expected, @todo.to_s
  end

  def test_attr_accessor
    @todo.id = 5
    @todo.title = "New title"
    @todo.done = true
    assert_equal 5, @todo.id
    assert_equal "New title", @todo.title
    assert_equal true, @todo.done
  end
end