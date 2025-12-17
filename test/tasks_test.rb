require "test_helper"

class TasksTest < ActionDispatch::IntegrationTest
  setup do
    # テスト用ユーザー作成
    @user = User.create!(
      name: "テストユーザー",
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )

    # ログイン状態を作る
    post login_path, params: { email: @user.email, password: "password" }

    # テスト用タスク作成
    @task = @user.tasks.create!(
      title: "サンプルタスク",
      content: "テスト用タスク",
      effort: 3,
      deadline: Date.today,
      priority: 2,
      done: false
    )
  end

  test "タスク一覧が表示される" do
    get tasks_path
    assert_response :success
    assert_select "h1", "タスク一覧"
  end

  test "新規タスクを作成できる" do
    assert_difference('Task.count', 1) do
      post tasks_path, params: { task: { title: "新規タスク", content: "内容", effort: 2, deadline: Date.today, priority: 3, done: false } }
    end
    assert_redirected_to tasks_path
    follow_redirect!
    assert_match "タスクを登録しました。", response.body
  end

  test "タスクを編集できる" do
    get edit_task_path(@task)
    assert_response :success

    patch task_path(@task), params: { task: { title: "更新タスク" } }
    assert_redirected_to tasks_path
    follow_redirect!
    assert_match "タスクを更新しました。", response.body
    @task.reload
    assert_equal "更新タスク", @task.title
  end

  test "タスクを削除できる" do
    assert_difference('Task.count', -1) do
      delete task_path(@task)
    end
    assert_redirected_to tasks_path
    follow_redirect!
    assert_match "タスクを削除しました。", response.body
  end

  test "タスクを並び替えできる" do
    # 例として deadline で並び替え
    get tasks_path(sort: "deadline", direction: "desc")
    assert_response :success
    assert_select "h1", "タスク一覧"
  end
end
