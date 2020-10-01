require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
    # @tweet.image = fixture_file_upload ('public/images/test_image.png')
  end

  describe '料理投稿の新規登録' do
    context '新規登録がうまくいく時' do
      it 'tweet_nameなど全てが存在すれば登録できる' do
        expect(@tweet).to be_valid
      end
    end
    context '新規登録がうまくいかない時' do
      it "tweet_nameが空だと登録できない" do
        @tweet.tweet_name = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Tweet nameを入力してください。")
      end
      it "tweet_textが空だと登録できない" do
        @tweet.tweet_text = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Tweet textを入力してください。")
      end
      it "imageが空だと登録できない" do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Imageを入力してください。")
      end
    end
  end
end
