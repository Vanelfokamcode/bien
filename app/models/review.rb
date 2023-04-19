class Review < ApplicationRecord

    # review has many comment associate to it 1-many relation
    has_many :comments

    has_many :bookmarks
    # add an association to the user
    belongs_to :user

    geocoded_by :address
    after_validation :geocode

    # add photo uploader
    mount_uploader :photo, PhotoUploader

    validates :title, presence: true
    validates :body, presence: true, length: {minimum: 10}
    validates :score, presence: true, numericality: {only_integer: true, greater_than_or_equal: 0, less_than_or_equal: 10}
    validates :restaurant, presence: true
    validates :address, presence: true

    def to_param
        [id, title.parameterize].join("-")
    end
end
