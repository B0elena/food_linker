require 'rails_helper'

RSpec.describe "イベント情報の投稿", type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @event = FactoryBot.build(:event)
  end
  context 'イベント情報の投稿ができるとき'do
    it 'ログインした料理人はイベント情報の投稿ができる' do
      # ログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @admin.email
      fill_in 'admin_password', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # イベント情報の投稿ページへのリンクがあることを確認する
      expect(page).to have_content('イベント情報登録')
      # 投稿ページに移動する
      visit new_event_path
      # フォームに情報を入力する
      fill_in 'event_event_name', with: @event.event_name
      fill_in 'event_event_text', with: @event.event_text
      fill_in 'event_prefecture', with: @event.prefecture
      fill_in 'event_city', with: @event.city
      fill_in 'event_block', with: @event.block
      fill_in 'event_phone', with: @event.phone
      # 送信するとeventモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Event.count }.by(1)
      # トップページに遷移する
      visit root_path
      # イベント情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('イベント情報')
      # 一覧ページに移動する
      visit events_path
      # 一覧ページに先ほど投稿した内容のイベント情報が存在することを確認する
      expect(page).to have_content(@event_id)
    end
  end
  context 'イベント情報の投稿ができないとき'do
    it 'ログインしていないとイベント情報の投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('イベント情報登録')
    end
  end
end

RSpec.describe 'イベント情報の編集', type: :system do
  before do
    @event1 = FactoryBot.create(:event)
    @event2 = FactoryBot.create(:event)
  end
  context 'イベントの編集ができるとき' do
    it 'ログインした料理人は自分が投稿したイベント情報の編集ができる' do
      # event1を投稿した料理人でログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @event1.admin.email
      fill_in 'admin_password', with: @event1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # イベント情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('イベント情報')
      # 一覧ページに移動する
      visit events_path
      # event1に「編集」ボタンがあることを確認する
      have_link '編集', href: edit_event_path(@event1)
      # 編集ページへ遷移する
      visit edit_event_path(@event1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#event_event_name').value
      ).to eq @event1.event_name
      expect(
        find('#event_event_text').value
      ).to eq @event1.event_text
      expect(
        find('#event_prefecture').value
      ).to eq @event1.prefecture
      expect(
        find('#event_city').value
      ).to eq @event1.city
      expect(
        find('#event_block').value
      ).to eq @event1.block
      expect(
        find('#event_phone').value
      ).to eq @event1.phone
      # 投稿内容を編集する
      fill_in 'event_event_name', with: @event1.event_name
      fill_in 'event_event_text', with: @event1.event_text
      fill_in 'event_prefecture', with: @event1.prefecture
      fill_in 'event_city', with: @event1.city
      fill_in 'event_block', with: @event1.block
      fill_in 'event_phone', with: @event1.phone
      # 編集してもEventモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Event.count }.by(0)
      # 一覧ページに移動する
      visit events_path
    end
  end
  context 'イベント情報の編集ができないとき' do
    it 'ログインした料理人は自分以外が投稿したイベント情報の編集画面には遷移できない' do
      # event1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @event1.admin.email
      fill_in 'admin_password', with: @event1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # イベント情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('イベント情報')
      # 一覧ページに移動する
      visit events_path
      # event2に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_event_path(@event2)
    end
    it 'ログインしていないとイベント情報の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # event1に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_event_path(@event1)
      # event2に「編集」ボタンがないことを確認する
      have_no_link '編集', href: edit_event_path(@event2)
    end
  end
end

RSpec.describe 'イベント情報の削除', type: :system do
  before do
    @event1 = FactoryBot.create(:event)
    @event2 = FactoryBot.create(:event)
  end
  context 'イベント情報の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したイベント情報の削除ができる' do
      # event1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @event1.admin.email
      fill_in 'admin_password', with: @event1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # イベント情報の一覧ページへのリンクがあることを確認する
      expect(page).to have_content('イベント情報')
      # 一覧ページに移動する
      visit events_path
      # event1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除', href: event_path(@event1)).click
      }.to change { Event.count }.by(-1)
      # 一覧ページに移動する
      visit root_path
      # 一覧ページに先ほど投稿した内容のイベント情報が存在しないことを確認する
      expect(page).to have_no_content(@event1)
    end
  end
  context 'イベント情報の削除ができないとき' do
    it 'ログインした料理人は自分以外が投稿したイベント情報の削除ができない' do
      # event1を投稿したユーザーでログインする
      visit new_admin_session_path
      fill_in 'admin_email', with: @event1.admin.email
      fill_in 'admin_password', with: @event1.admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # event2に「削除」ボタンが無いことを確認する
      have_no_link '削除', href: event_path(@event2)
    end
    it 'ログインしていないとイベント情報の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # event1に「削除」ボタンが無いことを確認する
      have_no_link '削除', href: event_path(@event1)
      # event2に「削除」ボタンが無いことを確認する
      have_no_link '削除', href: event_path(@event2)
    end
  end
end