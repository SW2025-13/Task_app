require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @task = tasks(:one)

    visit login_path

    fill_in "メールアドレス（ID）", with: @user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"

    # ★ ここが超重要（ログイン確認）
    assert_current_path tasks_path
    assert_selector "h1", text: "タスク一覧"
  end

  test "タスク一覧が表示される" do
    assert_selector "h1", text: "タスク一覧"
  end

  test "新規タスクを作成" do
    click_on "＋ 新規タスクを作成"

    fill_in "タイトル", with: "SystemTestタスク"
    fill_in "労力", with: 3
    fill_in "優先度", with: 2
    fill_in "期限", with: Date.today + 3

    click_on "登録"

    assert_text "タスクを登録しました"
  end

  test "タスクを編集" do
    click_on "編集", match: :first
    fill_in "タイトル", with: "編集後タイトル"
    click_on "更新"

    assert_text "タスクを更新しました"
  end

  test "タスクを削除" do
    click_on "削除", match: :first
    assert_text "タスクを削除しました"
  end

  test "並び替えが動作する" do
    click_on "労力"
    assert_selector "h1", text: "タスク一覧"
  end
end
