class RentSerializer < ActiveModel::Serializer
  attributes :id, :from, :to

  belongs_to :user
  belongs_to :book
end
