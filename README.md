# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## アプリケーション名
FOOD LINKER
料理人で作り上げるSNS

## アプリケーション概要
「料理人で作り上げるSNS」をテーマにしたアプリケーションを作りました。ログイン機能をdeviseで実装したのですが、料理人視点と一般のユーザー視点の２つの視点から使えるようにしました。料理人でログインすると料理の投稿、求人投稿、イベント投稿ができます。一般ユーザーでログインすると料理に対してのコメントのみできる仕様になっています。

## URL
https://food-linker.herokuapp.com/

## 使用技術
HTML / CSS / SCSS / JavaScript / ruby 2.6.5 / rails 6.0.0 / MySQL2 / AWS S3 / Git / GitHub /

## 目指した課題解決
一番解決したいと思った課題は一般ユーザー視点でのシンプルさです。「できる事がコメントと観覧のみに絞る事」と「ボタンなどのわかりやすさ」を上げる事で利用のストレスを減らすことを考えました。なぜそう思ったかというと、このアプリの１番の目的はイベントや求人情報を利用して繋がっていくこと、つまりリンクしていくことなので情報に早くたどり着けられるように、そういう課題を１番にしました。

## 実装した機能についてのGIFと説明
- userのログイン機能(一般ユーザー)
- adminのログイン機能(料理人)
- tweetの投稿　一覧　詳細　編集　削除の機能(料理の投稿)
- eventの投稿　一覧　詳細　編集　削除の機能(イベントの投稿)
- workの投稿　一覧　詳細　編集　削除の機能(求人の投稿)
- tweetに対するコメント機能(料理投稿に対してのコメント)
- お問い合わせ機能(管理者に対してのメッセージ送信機能)

## 実装予定の機能
- 料理人同士でコミュニケーションが取れるようにチャットルームを予定
- 検索機能を予定
- 料理人の詳細ページを予定

## データベース設計
### adminsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| l_name | string | null: false |
| f_name | string | null: false |
| email | string | null: false |
| password | string | null: false |
### Association
- has_many :tweets
- has_many :events
- has_many :works
- has_many :admin_rooms 
- has_many :rooms, through: admin_rooms
- has_many :posts
- has_one_attached :image

### usersテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| nickname | string | null: false |
| email | string | null: false |
| password | string | null: false |
### Association
- has_many :comments

### tweetsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| tweet_name | string | null: false |
| tweet_text | string | null: false |
| admin_id | references | null: false, foreign_key: true |
### Association
- belongs_to :admin
- has_many :comments
- has_one_attached :image

### commentsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| comment_text | string | null: false |
| user_id | references | null: false, foreign_key: true |
| tweet_id | references | null: false, foreign_key: true |
### Association
- belongs_to :tweet
- belongs_to :user

### eventsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| event_name | string | null: false |
| event_text | string | null: false |
| prefecture | string | null: false |
| city | string | null: false |
| block | string | null: false |
| building | string | |
| date | datetime | null: false |
| phone | string | null: false |
| admin_id | references | null: false, foreign_key: true |
### Association
- belongs_to :admin

### worksテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| shop_name | string | null: false |
| employment_status_id | integer | null: false |
| work_name | string | null: false |
| work_text | string | null: false |
| phone | string | null: false |
| admin_id | references | null: false, foreign_key: true |
### Association
- belongs_to :admin

### roomsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| room_name | string | null: false |
### Association
- has_many :posts
- has_many :admin_rooms
- has_many :admins, through: admin_rooms

### admin_roomsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| admin_id | references | null: false, foreign_key: true |
| room_id | references | null: false, foreign_key: true |
### Association
- belongs_to :admin
- belongs_to :room

### postsテーブル
| Column   | Type   | Options     |
| -------- | ------ | ----------- |
| post_text | string | null: false |
| admin_id | references | null: false, foreign_key: true |
### Association
- belongs_to :admin
- belongs_to :room
- has_one_attached :image

## ER図
https://app.diagrams.net/#G1U7wnE44zb40v6hDMuWt9Hv3EeQ80Ou-z

