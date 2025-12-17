require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password"
    )

    post login_path, params: {
      email: @user.email,
      password: "password"
    }

    @task = @user.tasks.create!(
      title: "テストタスク",
      content: "これはテスト用タスクです",
      effort: 3,
      priority: 2,
      deadline: Date.today + 7.days,
      done: false
    )
  end

  test "タスク一覧が表示される" do
    get tasks_url
    assert_response :success
    assert_select "td", text: @task.title
  end

  test "新規タスクを作成できる" do
    assert_difference("Task.count", 1) do
      post tasks_url, params: { task: {
        title: "新規タスク",
        content: "新しいタスク内容",
        effort: 2,
        priority: 1,
        deadline: Date.today + 3.days,
        done: false
      } }
    end
    assert_redirected_to tasks_url
  end

  test "タスクを更新できる" do
    patch task_url(@task), params: { task: { title: "更新タスク" } }
    assert_redirected_to tasks_url
    assert_equal "更新タスク", @task.reload.title
  end

  test "タスクを削除できる" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end
    assert_redirected_to tasks_url
  end
end
