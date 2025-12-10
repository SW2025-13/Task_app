require "test_helper"

class TaskTest < ActiveSupport::TestCase
  
  test "有効なタスクは保存できる" do
    task = Task.new(
      title: "有効タスク",
      effort: 3,
      priority: 2,
      content: "説明",
      deadline: Date.today + 1
    )
    assert task.valid?
  end

  test "タイトルは必須" do
    task = Task.new(title: "", effort: 3, deadline: Date.today + 1)
    assert_not task.valid?
  end

  test "期限(deadline)は必須" do
    task = Task.new(title: "No deadline", effort: 3, priority: 2)
    assert_not task.valid?
  end

  test "労力は1〜5の範囲" do
    task = Task.new(title: "test", effort: 6, deadline: Date.today + 1)
    assert_not task.valid?

    task.effort = 0
    assert_not task.valid?

    task.effort = 3
    assert task.valid?
  end

  test "優先度は1〜5の範囲" do
    task = Task.new(title: "test", priority: 10, deadline: Date.today + 1)
    assert_not task.valid?

    task.priority = -1
    assert_not task.valid?

    task.priority = 3
    assert task.valid?
  end
end
