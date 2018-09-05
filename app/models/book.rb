class Book < ApplicationRecord
  validates :genre, :author, :image, :title, :publisher, :year, presence: true
  # Relations
  has_many :rents, dependent: :destroy
  has_many :users, through: :rents
  include Filterable
end
