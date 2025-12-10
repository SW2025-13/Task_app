require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    log_in_as(@user)   # ←必ずログインする
    @task = tasks(:one)
  end

  test "index が表示される" do
    get tasks_url
    assert_response :success
    assert_select "h1", "タスク一覧"
  end

  test "new が表示される" do
    get new_task_url
    assert_response :success
  end

  test "タスクを作成できる" do
    assert_difference("Task.count", 1) do
      post tasks_url, params: {
        task: {
          title: "新規タスク",
          effort: 3,
          priority: 2,
          deadline: Date.today + 1
        }
      }
    end
    assert_redirected_to tasks_url
  end

  test "タスク作成に失敗（期限なし）" do
    assert_no_difference("Task.count") do
      post tasks_url, params: {
        task: {
          title: "期限なしタスク",
          effort: 3,
          priority: 2
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "タスクを更新できる" do
    patch task_url(@task), params: {
      task: { title: "更新タイトル" }
    }
    assert_redirected_to tasks_url
  end

  test "タスクを削除できる" do
    assert_difference("Task.count", -1) do
      delete task_url(@task)
    end
    assert_redirected_to tasks_url
  end
end
