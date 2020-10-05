require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @tweet = FactoryBot.create(:tweet)
    @comment = FactoryBot.build(:comment)
  end
  context '料理投稿にコメントができるとき'do
    it 'ログインしたユーザーは料理詳細ページでコメント投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 料理の詳細ページに遷移する
      visit tweet_path(@tweet)
      # フォームに情報を入力する
      fill_in 'comment_comment_text', with: @comment.comment_text
      # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Comment.count }.by(1)
      # 詳細ページにリダイレクトされることを確認する
      expect(current_path).to eq tweet_path(@tweet)
      # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
      expect(page).to have_content(@comment_id)
    end
  end
  context '料理投稿にコメントができないとき'do
    it 'ログインしていないと料理詳細ページにでコメントできない' do
      # トップページに遷移する
      visit root_path
      # 料理の詳細ページに遷移する
      visit tweet_path(@tweet)
      # コメントの入力フォームがない
      have_no_link '送信', href: tweet_path(@tweet)
    end
  end
end
