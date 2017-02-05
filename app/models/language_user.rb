class LanguageUser < ApplicationRecord
  belongs_to :language
  belongs_to :user
  validates :user_id,  presence: true
  validates :language_id, presence: true
  validates :level,    presence: true
  enum level: {beginner: 0, intermediate: 1, proficient: 2 }
end
