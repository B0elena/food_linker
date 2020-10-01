require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'コメントの投稿' do
    context '投稿がうまくいく時' do
      it 'comment_textが存在すれば登録できる' do
        expect(@comment).to be_valid
      end
    end
    context '投稿がうまくいかない時' do
      it "comment_textが空だと投稿できない" do
        @comment.comment_text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Comment textを入力してください。")
      end
    end
  end
end
