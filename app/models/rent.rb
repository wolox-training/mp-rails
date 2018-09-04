class Rent < ApplicationRecord
  validates :book, :user, :from, :to, presence: true
  belongs_to :book
  belongs_to :user
  validate :to_cannot_be_lesser_than_from,
           unless: -> { from.nil? || to.nil? }

  def to_cannot_be_lesser_than_from
    errors.add(:to, "can't be lesser than from") if to < from
  end
end
