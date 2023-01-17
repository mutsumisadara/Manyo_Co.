require 'rails_helper'
require 'date'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'タイトル1', to_do: '内容1', deadline: 'DateTime.now') }
  let!(:second_task) { FactoryBot.create(:second_task,title: 'タイトル2', to_do: '内容2', deadline: 'DateTime.tomorrow') }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      example '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'タイトル1'
        fill_in 'task[to_do]', with: '内容1'
        fill_in 'task_deadline', with: "002023-01-01"
        select '未着手', from: 'task[status]'
        select '高', from: 'task[priority]'
        click_button '登録する'
        expect(page).to have_content 'タイトル1'
        expect(page).to have_content '内容1'
        expect(page).to have_content '2023-01-01'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      example '作成済みのタスク一覧が表示される' do
        visit root_path
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '内容'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      example '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        second_task = FactoryBot.create(:second_task)
        third_task = FactoryBot.create(:third_task)
        # visit tasks_path = visit "/tasks"
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タイトル3'
        expect(task_list[1]).to have_content 'タイトル2'
        expect(task_list[2]).to have_content 'タイトル1'
      end
    end
    context '終了期限がソートボタンを押した場合' do
      example '終了期限順にタスクが表示される' do
        task = FactoryBot.create(:task)
        second_task = FactoryBot.create(:second_task)
        # third_task = FactoryBot.create(:third_task)
        visit tasks_path
        click_link '終了期限でソート'
        task_list = all('.task_row')   
        expect(task_list[0]).to have_content 'タイトル1'
        expect(task_list[1]).to have_content 'タイトル2'
        # expect(task_list[2]).to have_content 'タイトル3'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       example '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'タイトル', to_do: '内容')
        visit tasks_path(Task.last.id) #詳細画面タスクのid取得、多分
        click_link '詳細', match: :first #複数の要素の中から最初の要素を指定
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '詳細'
       end
     end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      example "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task_title', with: 'タイトル1' # タスクの検索欄に検索ワードを入力する (例: task)
        # select 'task_status'
        click_button '検索'# 検索ボタンを押す
        expect(page).to have_content 'タイトル1'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: 'task[status]'
        click_button '検索'
        expect(page).to have_content '未着手'
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task_title', with: 'タイトル1'
        select '未着手', from: 'task[status]'
        click_button '検索'
        expect(page).to have_content '未着手'
        # ここに実装する
      end
    end
  end
end