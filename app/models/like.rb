class Like < ApplicationRecord
  belongs_to :author
  belongs_to :likeable, polymorphic: true

  validates :author_id, uniqueness: { scope: %i[likeable_id likeable_type] }
end
