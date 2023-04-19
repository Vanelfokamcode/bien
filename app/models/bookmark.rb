class Bookmark < ApplicationRecord
  belongs_to :review
  belongs_to :user

  #one user per review 
  validates :review, uniqueness: {scope: :user}
  
end
