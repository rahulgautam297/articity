class Language < ApplicationRecord
  has_many :users, through: :language_users
  has_many :language_users
end
