require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end
  describe 'イベントの新規登録' do
    context '新規登録がうまくいく時' do
      it 'event_nameなど全てが存在すれば登録できる' do
        expect(@event).to be_valid
      end
    end
    context '新規登録がうまくいかない時' do
      it "event_nameが空だと登録できない" do
        @event.event_name = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Event nameを入力してください。")
      end
      it "event_textが空だと登録できない" do
        @event.event_text = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Event textを入力してください。")
      end
      it "prefectureが空だと登録できない" do
        @event.prefecture = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Prefectureを入力してください。")
      end
      it "cityが空だと登録できない" do
        @event.city = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Cityを入力してください。")
      end
      it "blockが空だと登録できない" do
        @event.block = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Blockを入力してください。")
      end
      it "dateが空だと登録できない" do
        @event.date = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Dateを入力してください。")
      end
      it "phoneが空だと登録できない" do
        @event.phone = ""
        @event.valid?
        expect(@event.errors.full_messages).to include("Phoneを入力してください。")
      end
      it '連絡先が半角数字でないと登録できない' do
        @event.phone = '３００'
        @event.valid?
        expect(@event.errors.full_messages).to include('Phoneは不正な値です。')
      end
    end
  end
end
