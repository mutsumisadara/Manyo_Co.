require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do

    describe 'ラベル機能' do
        context 'タスクを新規作成した場合' do
            it 'ラベルも登録ができる' do
                user = FactoryBot.create(:user)
                label = FactoryBot.create(:label)
                second_label = FactoryBot.create(:second_label)
                third_label = FactoryBot.create(:third_label)
                visit new_session_path
                fill_in 'session_email', with: user.email
                fill_in 'session_password', with: user.password
                click_button 'ログイン'
                visit new_task_path
                fill_in 'task[title]', with: 'タイトル1'
                fill_in 'task[to_do]', with: '内容1'
                fill_in 'task_deadline', with: "002023-01-01"
                select '未着手', from: 'task[status]'
                select '高', from: 'task[priority]'
                # check 'label1', from: 'task_label_id_1'
                check 'label1'
                click_button '登録する'
                expect(page).to have_content 'label1'
            end
        end
        context 'タスクの編集をする場合' do
            it 'ラベルも編集ができる' do
                user = FactoryBot.create(:user)
                label = FactoryBot.create(:label)
                second_label = FactoryBot.create(:second_label)
                third_label = FactoryBot.create(:third_label)
                visit new_session_path
                fill_in 'session_email', with: user.email
                fill_in 'session_password', with: user.password
                click_button 'ログイン'
                visit new_task_path
                fill_in 'task[title]', with: 'タイトル1'
                fill_in 'task[to_do]', with: '内容1'
                fill_in 'task_deadline', with: "002023-01-01"
                select '未着手', from: 'task[status]'
                select '高', from: 'task[priority]'
                check 'label1'
                click_button '登録する'
                visit edit_task_path(Task.last)
                check 'label1'
                click_button '更新する'
                expect(page).to have_content 'label1'
            end
        end
        context 'ラベル検索をする場合' do
            it 'ラベルで検索ができる' do
                user = FactoryBot.create(:user)
                label = FactoryBot.create(:label)
                second_label = FactoryBot.create(:second_label)
                third_label = FactoryBot.create(:third_label)
                visit new_session_path
                fill_in 'session_email', with: user.email
                fill_in 'session_password', with: user.password
                click_button 'ログイン'
                visit tasks_path
                select 'label1', from:'task_label_ids'
                click_button '検索'
                expect(page).to have_content 'label1'
            end
        end
    end
end