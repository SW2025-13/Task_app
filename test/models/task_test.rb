require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password"
    )

    @valid_task_attrs = {
      title: "テストタスク",
      content: "タスクの詳細",
      effort: 3,
      priority: 2,
      deadline: Date.today + 7.days,
      done: false,
      user: @user
    }
  end

  test "有効なタスクが作成できる" do
    task = Task.new(@valid_task_attrs)
    assert task.valid?
  end

  test "タイトルがなければ無効" do
    task = Task.new(@valid_task_attrs.merge(title: ""))
    assert_not task.valid?
  end

  test "努力値が1〜5でなければ無効" do
    assert_not Task.new(@valid_task_attrs.merge(effort: 0)).valid?
    assert_not Task.new(@valid_task_attrs.merge(effort: 6)).valid?
  end

  test "優先度が1〜5でなければ無効" do
    assert_not Task.new(@valid_task_attrs.merge(priority: 0)).valid?
    assert_not Task.new(@valid_task_attrs.merge(priority: 6)).valid?
  end

  test "ユーザーがなければ無効" do
    task = Task.new(@valid_task_attrs.merge(user: nil))
    assert_not task.valid?
  end
end
