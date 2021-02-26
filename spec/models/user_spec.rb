require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    it 'nickname、email、password、password_confirmation、first_name、last_name、first_reading、last_reading、birthdayが存在すれば登録できる' do
      expect(@user).to be_valid
    end
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include ("Nickname can't be blank")
    end
    it 'emailが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include ("Email can't be blank")
    end
    it '重複したemailが存在する場合登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'emailが@を含んでいないと登録できない' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it 'passwordが5文字以下では登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passwordが半角数字のみの場合は登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it 'passwordが半角英字のみの場合は登録できない' do
      @user.password = 'testtest'
      @user.password_confirmation = 'testtest'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it 'passwordに全角文字が存在する場合登録できない' do
      @user.password = 'testtest１'
      @user.password_confirmation = 'testtest１'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end
    it 'passwordが存在してもpassword_confirmationが空では登録できない' do
      @user.password = 'test1234'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'passwordとpassword_confirmationの値が同一でなければ登録できない' do
      @user.password = 'test1234'
      @user.password_confirmation = 'testtest'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '本名はfirst_nameがなければ登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name Full-width characters")
    end
    it '本名はlast_nameがなければ登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name Full-width characters")
    end
    it 'first_nameは全角(漢字、平仮名、カタカナ)でなければ登録できない' do
      @user.first_name = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters")
    end
    it 'last_nameは全角(漢字、平仮名、カタカナ)でなければ登録できない' do
      @user.last_name = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name Full-width characters")
    end
    it '本名はfirst_readingがなければ登録できない' do
      @user.first_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First reading can't be blank",
        "First reading Full-width katakana characters")
    end
    it '本名はlast_readingがなければ登録できない' do
      @user.last_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last reading can't be blank", "Last reading Full-width katakana characters")
    end
    it 'first_readingはカタカナでなければ登録できない' do
      @user.first_reading = '隆太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include("First reading Full-width katakana characters")
    end
    it 'last_readingはカタカナでなければ登録できない' do
      @user.last_reading = '山田'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last reading Full-width katakana characters")
    end
    it 'birthdayが空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
