require 'rails_helper'

RSpec.describe "料理の投稿", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @tweet = FactoryBot.build(:tweet)
  end
  context '料理の投稿ができるとき'do
    it 'ログインした料理人は料理の投稿ができる' do
      # ログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 料理の投稿ページへのリンクがあることを確認する
      expect(page).to have_content('料理の投稿')
      # 投稿ページに移動する
      visit new_tweet_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_tweet_name', with: @tweet.tweet_name
      fill_in 'tweet_tweet_text', with: @tweet.tweet_text
      # 送信するとWorkモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # トップページに遷移する
      visit root_path
      # 一覧ページに先ほど投稿した内容の料理の投稿が存在することを確認する
      expect(page).to have_content(@tweet_id)
    end
  end
  context '料理の投稿ができないとき'do
    it 'ログインしていないと料理の投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('料理の投稿')
    end
  end
end

RSpec.describe '料理の編集', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context '料理の編集ができるとき' do
    it 'ログインした料理人は自分が投稿した料理の編集ができる' do
      # twwet1を投稿した料理人でログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @tweet1.admin.email
      fill_in 'admin_password', with: @tweet1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 料理の詳細ページに移動する
      visit tweet_path(@tweet1)
      # tweet1に「編集」ボタンがあることを確認する
      have_link '編集', href: edit_tweet_path(@tweet1)
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#tweet_tweet_name').value
      ).to eq @tweet1.tweet_name
      expect(
        find('#tweet_tweet_text').value
      ).to eq @tweet1.tweet_text
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('tweet[image]', image_path, make_visible: true)
      fill_in 'tweet_tweet_name', with: @tweet1.tweet_name
      fill_in 'tweet_tweet_text', with: @tweet1.tweet_text
      # 編集してもWorkモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(0)
      # 一覧ページに移動する
      visit root_path
    end
  end
  context '料理の編集ができないとき' do
    it 'ログインした料理人は自分以外が投稿した料理の編集画面には遷移できない' do
      # tweet1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @tweet1.admin.email
      fill_in 'admin_password', with: @tweet1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # tweet2の詳細ページに移動する
      visit tweet_path(@tweet2)
      # tweet2に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_tweet_path(@tweet2)
    end
    it 'ログインしていないと料理の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # tweet1の詳細ページに移動する
      visit tweet_path(@tweet1)
      # tweet1に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_tweet_path(@tweet1)
    end
  end
end

RSpec.describe '料理の削除', type: :system do
  before do
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context '料理の削除ができるとき' do
    it 'ログインした料理人は自分が投稿した料理の削除ができる' do
      # twwet1を投稿した料理人でログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @tweet1.admin.email
      fill_in 'admin_password', with: @tweet1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 料理の詳細ページに移動する
      visit tweet_path(@tweet1)
      # tweet1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除', href: tweet_path(@tweet1)).click
      }.to change { Tweet.count }.by(-1)
      # 一覧ページに移動する
      visit root_path
    end
  end
  context '料理の削除ができないとき' do
    it 'ログインした料理人は自分以外が投稿した料理の削除ができない' do
      # tweet1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @tweet1.admin.email
      fill_in 'admin_password', with: @tweet1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # tweet2の詳細ページに移動する
      visit tweet_path(@tweet2)
      # tweet2に「削除」ボタンがないことを確認する
      have_no_link '削除', href: tweet_path(@tweet2)
    end
    it 'ログインしていないとの料理の削除ができない' do
      # トップページにいる
      visit root_path
      # tweet1の詳細ページに移動する
      visit tweet_path(@tweet1)
      # tweet1に「削除」ボタンがないことを確認する
      have_no_link '削除', href: tweet_path(@tweet1)
    end
  end
end