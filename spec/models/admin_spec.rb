require 'rails_helper'
RSpec.describe Admin, type: :model do
  before do
    @admin = FactoryBot.build(:admin)
  end
  describe '料理人の新規登録' do
    context '新規登録がうまくいく時' do
      it 'l_nameなど全てが存在すれば登録できる' do
        expect(@admin).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @admin.password = 'aaa111'
        @admin.password_confirmation = 'aaa111'
        expect(@admin).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it "l_nameが空だと登録できない" do
        @admin.l_name = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("L nameを入力してください。")
      end
      it "f_nameが空だと登録できない" do
        @admin.f_name = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("F nameを入力してください。")
      end
      it "emailが空では登録できない" do
        @admin.email = ""
        @admin.valid?
        expect(@admin.errors.full_messages).to include("メールアドレスを入力してください。")
      end
      it '重複したemailが存在する場合登録できない' do
        @admin.save
        another_admin = FactoryBot.build(:admin, email: @admin.email)
        another_admin.valid?
        expect(another_admin.errors.full_messages).to include('メールアドレスはすでに存在します。')
      end
      it 'emailに@がないと登録できない' do
        @admin.email = 'testgmail.com'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('メールアドレスは不正な値です。')
      end
      it 'passwordが空では登録できない' do
        @admin.password = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include("パスワードを入力してください。")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @admin.password = '00000'
        @admin.password_confirmation = '00000'
        @admin.valid?
        expect(@admin.errors.full_messages).to include('パスワードは6文字以上で入力してください。')
      end
      it 'passwrordは半角英数字混合でないと登録できない' do
        @admin.password = '000000'
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Password confirmationとパスワードの入力が一致しません。")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @admin.password_confirmation = ''
        @admin.valid?
        expect(@admin.errors.full_messages).to include("Password confirmationとパスワードの入力が一致しません。")
      end
    end
  end
end

