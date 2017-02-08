class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,:omniauthable, :omniauth_providers => [:facebook]
  mount_uploader :picture, PictureUploader
  has_many :skills, through: :user_skills
  has_many :user_skills
  has_many :languages, through: :language_users
  has_many :language_users

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image # assuming the user model has an image
	    # If you are using confirmable and the provider(s) you use validate emails,
	    # uncomment the line below to skip the confirmation emails.
	    # user.skip_confirmation!
	  end
	end
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
  def image_size
    if image.size > 5.megabytes
      errors.add(:image, "Image size should be less than 5 MB")
    end
  end
  def return_specified_attributes(hash, level)
    new_hash=[]
    hash.each do |hash|
      obj= {}
      if level == true
        obj[:level_id] = hash[:id]
      else
        obj[:language_id] = hash[:id]
      end
      if hash[:level]
        obj[:level] = hash[:level]
      end
      if hash[:name]
        obj[:name] = hash[:name]
      end
      new_hash << obj
    end
    return new_hash
  end
  def merge_two(hash_1,hash_2)
    new_hash=[]
    hash = hash_1.zip(hash_2)
    hash.each do |hash|
      obj= {}
      obj[:language_id] = hash.first[:language_id]
      obj[:name] = hash.first[:name]
      obj[:level] = hash.second[:level]
      obj[:level_id] = hash.second[:level_id]
      new_hash << obj
    end
    return new_hash
  end
end
