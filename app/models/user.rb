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

  def add_levels(array)
    new_hash=[]
    level = LanguageUser.levels
    array.each do |hash|
      obj= {}
      obj[:name] = hash[:name]
      obj[:level_id] = hash.id
      current_level = level.rassoc(hash.level)[0]
      obj[:level] = current_level
      new_hash << obj
    end
    return new_hash
  end

  def add_skills_info(array)
    new_hash=[]
    array.each do |hash|
      obj= {}
      obj[:name] = hash[:name]
      obj[:description] = hash.description
      obj[:price] = hash.price
      obj[:portfolio] = hash.portfolio
      obj[:image] = hash.image
      new_hash << obj
    end
    return new_hash
  end
end
