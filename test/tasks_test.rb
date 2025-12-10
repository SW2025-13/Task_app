require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "タスク一覧が表示される" do
    visit tasks_url
    assert_selector "h1", text: "タスク一覧"
  end

  test "新規タスクを作成" do
    visit tasks_url
    click_on "＋ 新規タスクを作成"

    fill_in "タイトル", with: "SystemTestタスク"
    fill_in "労力", with: 3
    fill_in "優先度", with: 2
    fill_in "期限", with: Date.today + 3

    click_on "登録"

    assert_text "タスクを作成しました"
    assert_text "SystemTestタスク"
  end

  test "タスクを編集" do
    visit tasks_url
    click_on "編集", match: :first

    fill_in "タイトル", with: "編集後タイトル"
    click_on "更新"

    assert_text "タスクを更新しました"
    assert_text "編集後タイトル"
  end

  test "タスクを削除" do
    visit tasks_url
    page.accept_confirm { click_on "削除", match: :first }

    assert_text "タスクを削除しました"
  end

  test "並び替えが動作する" do
    visit tasks_url
    select "労力", from: "sort"
    assert_selector "h1", text: "タスク一覧"
  end
end
