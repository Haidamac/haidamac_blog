class Api::V1::ArticleSerializer < ActiveModel::Serializer
  has_many :tags
  has_many :comments
  attributes :id, :title, :body, :created_at, :author_name

  def author_name
    Author.find(object.author_id).name
  end
end
