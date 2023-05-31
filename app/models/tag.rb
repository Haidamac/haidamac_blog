class Tag < ApplicationRecord
  has_many :articletags
  has_many :articles, through: :articletags

  validates :tagname, presence: true
  scope :all_tags, -> { order('created_at DESC') }
end
