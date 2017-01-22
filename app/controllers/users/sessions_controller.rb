class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
respond_to :html, :js, :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #  super
  # end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def show
    @user=current_user
  end


  def picture
    @user=current_user
    if @user.update_attributes(user_params.except(:cover_picture))
      render action: :show
    else
      flash.add("Image couldn't be uploaded")
      render action: :show
    end
  end

  protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   #devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

def user_params
    params.require(:user).permit(:cover_picture, :picture)
  end

  private

  def require_no_authentication
    assert_is_devise_resource!
    return unless is_navigational_format?
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
      args = no_input.dup.push scope: resource_name
      warden.authenticate?(*args)
    else
      warden.authenticated?(resource_name)
    end

    if authenticated && resource = warden.user(resource_name)
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to action: :show
    end
  end
end
