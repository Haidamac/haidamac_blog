class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :status, :author_name, :created_at

  def author_name
    Author.find(object.author_id).name
  end
end
