require 'rails_helper'

RSpec.describe "求人情報の投稿", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @work = FactoryBot.build(:work)
  end
  context '求人情報の投稿ができるとき'do
    it 'ログインした料理人は求人情報の投稿ができる' do
      # ログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 求人情報の投稿ページへのリンクがあることを確認する
      expect(page).to have_content('求人情報登録')
      # 投稿ページに移動する
      visit new_work_path
      # フォームに情報を入力する
      fill_in 'work_shop_name', with: @work.shop_name
      select('正社員', from: 'work_employment_status_id').select_option
      fill_in 'work_work_name', with: @work.work_name
      fill_in 'work_work_text', with: @work.work_text
      fill_in 'work_phone', with: @work.phone
      # 送信するとWorkモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(1)
      # トップページに遷移する
      visit root_path
      # 求人情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('求人情報')
      # 一覧ページに移動する
      visit works_path
      # 一覧ページに先ほど投稿した内容の求人情報が存在することを確認する
      expect(page).to have_content(@work_id)
    end
  end
  context '求人情報の投稿ができないとき'do
    it 'ログインしていないと求人情報の投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('求人情報登録')
    end
  end
end

RSpec.describe '求人情報の編集', type: :system do
  before do
    @work1 = FactoryBot.create(:work)
    @work2 = FactoryBot.create(:work)
  end
  context '求人編集ができるとき' do
    it 'ログインした料理人は自分が投稿した求人情報の編集ができる' do
      # work1を投稿した料理人でログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @work1.admin.email
      fill_in 'admin_password', with: @work1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 求人情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('求人情報')
      # 一覧ページに移動する
      visit works_path
      # work1に「編集」ボタンがあることを確認する
      have_link '編集', href: edit_work_path(@work1)
      # 編集ページへ遷移する
      visit edit_work_path(@work1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#work_shop_name').value
      ).to eq @work1.shop_name
      expect(
        find('#work_work_name').value
      ).to eq @work1.work_name
      expect(
        find('#work_work_text').value
      ).to eq @work1.work_text
      expect(
        find('#work_phone').value
      ).to eq @work1.phone
      # 投稿内容を編集する
      fill_in 'work_shop_name', with: @work1.shop_name
      select('正社員', from: 'work_employment_status_id').select_option
      fill_in 'work_work_name', with: @work1.work_name
      fill_in 'work_work_text', with: @work1.work_text
      fill_in 'work_phone', with: @work1.phone
      # 編集してもWorkモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Work.count }.by(0)
      # 一覧ページに移動する
      visit works_path
    end
  end
  context '求人情報の編集ができないとき' do
    it 'ログインした料理人は自分以外が投稿した求人情報の編集画面には遷移できない' do
      # work1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @work1.admin.email
      fill_in 'admin_password', with: @work1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 求人情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('求人情報')
      # 一覧ページに移動する
      visit works_path
      # work2に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_work_path(@work2)
    end
    it 'ログインしていないと求人情報の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # work1に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_work_path(@work1)
      # work2に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_work_path(@work2)
    end
  end
end

RSpec.describe '求人情報の削除', type: :system do
  before do
    @work1 = FactoryBot.create(:work)
    @work2 = FactoryBot.create(:work)
  end
  context '求人情報の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した求人情報の削除ができる' do
      # work1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @work1.admin.email
      fill_in 'admin_password', with: @work1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 求人情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('求人情報')
      # 一覧ページに移動する
      visit works_path
      # work1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除', href: work_path(@work1)).click
      }.to change { Work.count }.by(-1)
      # 一覧ページに移動する
      visit root_path
      # 一覧ページに先ほど投稿した内容の求人情報が存在しないことを確認する
      expect(page).to have_no_content(@work1)
    end
  end
  context '求人情報の削除ができないとき' do
    it 'ログインした料理人は自分以外が投稿した求人情報の削除ができない' do
      # work1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @work1.admin.email
      fill_in 'admin_password', with: @work1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # work2に「削除」ボタンが無いことを確認する
      have_no_link '削除', href: work_path(@work2)
    end
    it 'ログインしていないと求人情報の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # work1に「削除」ボタンが無いことを確認する
      have_no_link '削除', href: work_path(@work1)
      # work2に「削除」ボタンが無いことを確認する
      have_no_link '削除', href: work_path(@work2)
    end
  end
end