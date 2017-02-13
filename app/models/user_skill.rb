class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill
  validates :user_id, presence: true
  validates :skill_id, presence: true
  mount_uploader :multimedia, SkillUploader
end
