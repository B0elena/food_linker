require 'rails_helper'

RSpec.describe Work, type: :model do
  before do
    @work = FactoryBot.build(:work)
  end
  describe '求人の新規登録' do
    context '新規登録がうまくいく時' do
      it 'shop_nameなど全てが存在すれば登録できる' do
        expect(@work).to be_valid
      end
    end
    context '新規登録がうまくいかない時' do
      it "shop_nameが空だと登録できない" do
        @work.shop_name = ""
        @work.valid?
        expect(@work.errors.full_messages).to include("Shop nameを入力してください。")
      end
      it '雇用形態の情報が空だと登録できない' do
        @work.employment_status_id = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Employment statusを入力してください。")
      end
      it '雇用形態の情報で１を選択したら登録できない' do
        @work.employment_status_id = '1'
        @work.valid?
        expect(@work.errors.full_messages).to include('Employment statusは1以外の値にしてください。')
      end
      it '職種が空だと登録できない' do
        @work.work_name = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Work nameを入力してください。")
      end
      it '仕事の詳細が空だと登録できない' do
        @work.work_text = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Work textを入力してください。")
      end
      it '連絡先が空だと登録できない' do
        @work.phone = ''
        @work.valid?
        expect(@work.errors.full_messages).to include("Phoneを入力してください。")
      end
      it '連絡先が半角数字でないと登録できない' do
        @work.phone = '３００'
        @work.valid?
        expect(@work.errors.full_messages).to include('Phoneは不正な値です。')
      end
    end
  end
end
