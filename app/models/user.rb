class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  validates :first_name, :last_name, presence: true
  include DeviseTokenAuth::Concerns::User
end
