class User < ApplicationRecord
  before_save { self.email.downcase! }
  #保存する前に、emailをすべて小文字にする。
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum:255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
            #重複を許さず、大文字小文字の区別はしない。
  has_secure_password
  has_many :tasks
  
end
