class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /resource/sign_in
  def create
    caught = catch(:warden) do
      self.resource = warden.authenticate(auth_options)
      if self.resource
        set_flash_message(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        @message = "Invalid email or password."
        respond_to do |format|
          format.html{render partial: 'new', locals: { resource: resource_name }}
          format.js
        end
      end
    end
    if caught && caught.is_a?(Hash) && caught[:message]= "unconfirmed"
      @message = I18n.t 'devise.failure.unconfirmed'
      respond_to do |format|
        format.js
      end
    end
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   #devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  # def require_no_authentication
  #   assert_is_devise_resource!
  #   return unless is_navigational_format?
  #   no_input = devise_mapping.no_input_strategies

  #   authenticated = if no_input.present?
  #     args = no_input.dup.push scope: resource_name
  #     warden.authenticate?(*args)
  #   else
  #     warden.authenticated?(resource_name)
  #   end

  #   if authenticated && resource = warden.user(resource_name)
  #     flash[:alert] = I18n.t("devise.failure.already_authenticated")
  #     redirect_to after_sign_in_path_for(resource)
  #   end
  # end
  # Warden::Manager.before_failure do |env, opts|
  # end
end
