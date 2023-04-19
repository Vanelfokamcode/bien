class User < ApplicationRecord

    has_many :reviews
    has_many :bookmarks
    
    has_secure_password

    validates :username, presence: true, uniqueness: true 
    validates :email, presence: true, uniqueness: true
end
