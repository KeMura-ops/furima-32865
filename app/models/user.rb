class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders
  with_options presence: true do
    validates :nickname, :birthday
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は文字と数字の両方を含めてください' }
    validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: 'は全角文字で入力してください' }
    validates :first_reading, :last_reading, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナ文字で入力してください' }
  end
end
