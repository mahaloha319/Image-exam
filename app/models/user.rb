class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
    validates :email, presence: true, length: { maximum: 255},
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_save { email.downcase! } 
    has_secure_password # パスワードのハッシュ化（登録フォームの作成）
    validates :password, presence: true, length: { minimum: 6 }
    has_many :blogs, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_blogs, through: :favorites, source: :blog
    mount_uploader :icon, IconUploader #該当モデルにカラムとアップローダを指定
end
