class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  mount_uploader :picture, PictureUploader
  mount_uploader :cover_picture, PictureUploader
  has_many :skills, through: :user_skills
  has_many :user_skills
end
