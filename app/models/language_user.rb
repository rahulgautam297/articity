class LanguageUser < ApplicationRecord
  belongs_to :language
  belongs_to :user
  validates :user_id,  presence: true
  validates :language_id, presence: true
  validates :level,    presence: true
  enum level: {"Basic": 0, "Conversational": 1, "Fluent": 2, "Native or bilingual": 3 }
end
