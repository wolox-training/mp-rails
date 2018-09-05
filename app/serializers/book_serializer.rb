class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :genre, :publisher, :year, :image, :created_at, :updated_at

  def image
    { url: object.image }
  end
end
