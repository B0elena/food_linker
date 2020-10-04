require 'rails_helper'

RSpec.describe '料理人の新規登録', type: :system do
  before do
    @admin = FactoryBot.build(:admin)
  end
  context '料理人の新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('料理人の新規登録')
      # 新規登録ページへ移動する
      visit new_admin_registration_path
      # ユーザー情報を入力する
      fill_in 'admin_l_name', with: @admin.l_name
      fill_in 'admin_f_name', with: @admin.f_name
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      fill_in 'admin_password_confirmation', with: @admin.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Admin.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context '料理人の新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_admin_registration_path
      # ユーザー情報を入力する
      fill_in 'admin_l_name', with: ""
      fill_in 'admin_f_name', with: ""
      fill_in 'admin_email', with: ""
      fill_in 'admin_password', with: ""
      fill_in 'admin_password_confirmation', with: ""
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Admin.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/admins"
    end
  end
end

RSpec.describe '料理人のログイン', type: :system do
  before do
    @admin = FactoryBot.create(:admin)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('料理人のログイン')
      # ログインページへ遷移する
      visit new_admin_session_path
      # 正しいユーザー情報を入力する
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('料理人のログイン')
      # ログインページへ遷移する
      visit new_admin_session_path
      # ユーザー情報を入力する
      fill_in 'admin_email', with: ""
      fill_in 'admin_password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_admin_session_path
    end
  end
end
