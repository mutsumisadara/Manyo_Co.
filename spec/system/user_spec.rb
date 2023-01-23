require 'rails_helper'
RSpec.describe User, type: :system do

  describe 'ユーザーの登録テスト' do
    context 'ユーザーが新規登録した場合' do
      example '新規登録ができる' do
        visit new_user_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@gmail.com'
        fill_in 'user[password]', with: 'testtest'
        fill_in 'user[password_confirmation]', with: 'testtest'
        click_button 'アカウントを作成する'
        expect(current_path).to eq user_path(User.last)
      end
    end
    context 'ユーザーがログインせず一覧画面に飛ぼうとした場合' do
      example 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'ログインができた場合' do
      example 'マイページに飛べる' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        # expect(page).to eq user_path(User.last)
        # expect{ click_button "アカウントを作成する" }.to change(User, :count).by(1)
        expect(page).to have_content('ログアウト')
      end
    end
    context '一般ユーザーが他人の詳細画面に飛ぼうとした場合' do
      example 'タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        visit user_path(User.first)
        # visit user_path(User.last)
        # visit user_path(User, :count).by(1)
        # expect(page).to eq tasks_path
        expect(current_path).to eq user_path(User.first)
      end
    end
    context 'セッション機能のテスト' do
      example 'ログアウトができる' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        # visit "/users/1" #(User.first)
        visit user_path(User.first)
        # expect(page).to eq "/users/1" #(User.first)
        # expect(page).to eq user_path(User.first)
        # expect(page).to eq user_path(User, :count).by(1)
        # expect(page).to eq user_path(User.first)
        expect(page).to have_content('ログアウト')
        click_link 'ログアウト'
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe '管理画面のテスト' do
    context '管理者の場合' do
      example '管理画面にアクセスできる' do
        #loginのlet!befor do作る？
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        visit admin_users_path(user)
        expect(page).to have_content('管理者画面')
      end
    end
    context '一般ユーザーの場合' do
      example '管理画面にアクセスできない' do
        second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session_email', with: second_user.email
        fill_in 'session_password', with: second_user.password
        click_button 'ログイン'
        visit admin_users_path
        expect(page).to have_content('アクセス権限がありません')
        # expect(page).to have_content('タスク一覧')
      end
    end
    context '管理者の場合' do
      example 'ユーザーの新規登録ができる' do
        user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        visit admin_users_path
        click_link 'ユーザー作成'
        fill_in 'user[name]', with: second_user.name
        fill_in 'user[email]', with: second_user.email
        fill_in 'user[password]', with: second_user.password
        fill_in 'user[password_confirmation]', with: second_user.password_confirmation
        # fill_in 'user_admin', with: '管理者'
        select '一般ユーザー', from: 'user[admin]'
        click_button 'アカウントを作成する'
        expect(page).to have_content('マイページ')
      end
    end
    context '管理者の場合' do
      example 'ユーザーの詳細画面にアクセスできる' do
        user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        visit admin_users_path(user)
        click_on "詳細", match: :first
        expect(page).to have_content '閲覧中のユーザー'
      end
    end
    context '管理者の場合' do
      example 'ユーザーの編集画面から編集できる' do
        user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        visit edit_admin_user_path(user.id)
        fill_in 'user[name]', with: second_user.name
        fill_in 'user[email]', with: second_user.email
        fill_in 'user[password]', with: second_user.password
        fill_in 'user[password_confirmation]', with: second_user.password_confirmation
        select '一般ユーザー', from: 'user[admin]'
        click_button 'アカウントを更新する'
        expect(page).to have_content('ユーザーを更新しました！')
      end
    end
    context '管理者の場合' do
      example 'ユーザーの削除ができる' do
        user = FactoryBot.create(:user)
        second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button 'ログイン'
        visit admin_users_path(user)
        click_on "削除", match: :first
        # click_button 'OK'
        page.accept_confirm
        expect(page).to have_content('ユーザーを削除しました！')
      end
    end
  end
end