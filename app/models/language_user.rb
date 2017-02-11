class LanguageUser < ApplicationRecord
  belongs_to :language
  belongs_to :user
  validates :user_id,  presence: true
  validates :language_id, presence: true
  validates :level,    presence: true
  enum level: {"Basic": 1, "Conversational": 2, "Fluent": 3, "Native or bilingual": 4 }
end
