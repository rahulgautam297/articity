class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
prepend_before_action :authenticate_scope!, only: [:edit, :update, :destroy,
                                        :build_seller_profile, :upload_picture]
# before_action :configure_account_update_params, only: [:update]
respond_to :html, :js

  def build_seller_profile
    @user = current_user
    @languages_and_levels=@user.languages.select('languages.*,language_users.*')
    @languages_and_levels=@user.add_levels(@languages_and_levels)
    @languages = Language.all
  end

  def upload_picture
    @user = current_user
    @user.update_attributes(picture: user_params[:picture])
    render json:{done:"mofo!!!"}
  end

  def update_seller_info
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to skills_and_categories_path
    else
      render build_seller_profile
    end
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

 # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:picture,:description,:college,:locality,:state,:portfolio,:mobile])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  #
  # def after_update_path_for(resource)
  #   user_path(resource)
  # end

  private
    def user_params
      params.require(:user).permit(:name,:picture,:description,:college,:locality,:state,:portfolio,:mobile)
    end
end
