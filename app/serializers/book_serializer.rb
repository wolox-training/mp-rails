class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :genre, :publisher, :year, :image

  def image
    { url: object.image }
  end
end
