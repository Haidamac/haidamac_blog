class Comment < ApplicationRecord
  belongs_to :author
  belongs_to :article
  has_many :likes, as: :likeable
  enum status: { unpublished: 0, published: 1 }

  validates :author, :article, presence: true
  validates :body, presence: true, length: { minimum: 5, message: 'Comment must contain 5 characters at least' }
  scope :published_only, -> { where(status: 1) }
  scope :unpublished_only, -> { where(status: 0) }
end
