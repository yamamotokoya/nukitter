class User < ApplicationRecord
    has_secure_password

    has_one_attached :avatar

    has_many :likes, dependent: :destroy
    has_many :liked_posts, through: :likes, source: :post
    
    validates :email, presence: true, uniqueness: true
end
