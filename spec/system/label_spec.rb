RSpec.describe 'ラベル機能', type: :system do

    describe 'ラベル機能' do
        context 'タスクを新規作成した場合' do
            it 'ラベルも登録ができる' do
                user = FactoryBot.create(:user)
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
                select 'label1', from:'task[label_ids]'
                click_button '登録する'
                expect(page).to have_content 'タイトル1'
                expect(page).to have_content '内容1'
                expect(page).to have_content '2023-01-01'
                expect(page).to have_content '未着手'
                expect(page).to have_content '高'
                expect(page).to have_content 'label1'
            end
        end
        context 'タスクの編集をする場合' do
            it 'ラベルも編集ができる' do
                user = FactoryBot.create(:user)
                visit new_session_path
                fill_in 'session_email', with: user.email
                fill_in 'session_password', with: user.password
                click_button 'ログイン'
                visit edit_task_path
                fill_in 'task[title]', with: 'タイトル1'
                fill_in 'task[to_do]', with: '内容1'
                fill_in 'task_deadline', with: "002023-01-01"
                select '未着手', from: 'task[status]'
                select '高', from: 'task[priority]'
                select 'label1', from:'task[label_ids]'
                click_button '登録する'
                expect(page).to have_content 'タイトル1'
                expect(page).to have_content '内容1'
                expect(page).to have_content '2023-01-01'
                expect(page).to have_content '未着手'
                expect(page).to have_content '高'
                expect(page).to have_content 'label1'
            end
        end
        context 'ラベル検索をする場合' do
            it 'ラベルで検索ができる' do
                user = FactoryBot.create(:user)
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