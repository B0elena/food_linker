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

## アプリケーション概要

## URL

## テスト用アカウント

## 利用方法	

## 目指した課題解決

## 洗い出した要件

## 実装した機能についてのGIFと説明
- userのログイン機能
- adminのログイン機能
- tweetの投稿　一覧　編集　削除の機能
- eventの投稿　一覧　編集　削除の機能
- workの投稿　一覧　編集　削除の機能
- tweetに対するコメント機能
- お問い合わせ機能

## 実装予定の機能

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

## ローカルでの動作方法

