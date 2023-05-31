class Article < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_many :articletags
  has_many :tags, through: :articletags
  has_many :likes, as: :likeable
  enum status: { unpublished: 0, published: 1 }

  scope :status_filter, ->(status) { where(status: status) }
  scope :author_filter, ->(name) { joins(:author).where('name ILIKE ?', "%#{name}%") }
  scope :tag_filter, ->(tags) { joins(:tags).where(tags: { tagname: tags.split(',').collect { |tags| tags.strip.capitalize } }).distinct }

  validates :title, :body, presence: true
end
