require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録ができる時' do
      it 'nickname、email、password、password_confirmation、first_name、last_name、first_reading、last_reading、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationの値が同一であれば登録できる' do
        @user.password = "a12345"
        @user.password_confirmation = "a12345"
        expect(@user).to be_valid
      end
    end

    context '新規登録ができない時' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'emailが@を含んでいないと登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'passwordが半角数字のみの場合は登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは文字と数字の両方を含めてください")
      end
      it 'passwordが半角英字のみの場合は登録できない' do
        @user.password = 'testtest'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは文字と数字の両方を含めてください")
      end
      it 'passwordに全角文字が存在する場合登録できない' do
        @user.password = 'testtest１'
        @user.password_confirmation = 'testtest１'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは文字と数字の両方を含めてください")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password = 'test1234'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationの値が同一でなければ登録できない' do
        @user.password = 'test1234'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '本名はfirst_nameがなければ登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it '本名はlast_nameがなければ登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください")
      end
      it 'first_nameは全角(漢字、平仮名、カタカナ)でなければ登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字で入力してください")
      end
      it 'last_nameは全角(漢字、平仮名、カタカナ)でなければ登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字は全角文字で入力してください")
      end
      it '本名はfirst_readingがなければ登録できない' do
        @user.first_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
      end
      it '本名はlast_readingがなければ登録できない' do
        @user.last_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字(カナ)を入力してください")
      end
      it 'first_readingはカタカナでなければ登録できない' do
        @user.first_reading = '隆太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前(カナ)は全角カタカナ文字で入力してください")
      end
      it 'last_readingはカタカナでなければ登録できない' do
        @user.last_reading = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字(カナ)は全角カタカナ文字で入力してください")
      end
      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
