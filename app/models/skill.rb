class Skill < ApplicationRecord
	has_many :users, through: :user_skills
	has_many :user_skills
	belongs_to :skill_category
end
