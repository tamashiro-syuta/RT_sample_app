class User < ApplicationRecord
  # DBに保存する前に全て小文字にする
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50}
  
  # メールアドレスの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # uniqueness でcase_sensitive: false　にすることで、大文字小文字の区別を無くして判定することができる
  validates :email, presence: true, length: { maximum: 255},
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: true
                      
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
