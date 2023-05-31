class Author < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes

  validates :name, presence: { message: 'Must be given please' }, uniqueness: { message: 'This name already taken' }
end
