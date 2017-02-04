class UsersController < ApplicationController
before_action :authenticate_user!, only: [:build_profile, :upload_picture]
  def build_profile
    @user = current_user
  end

  def upload_picture
    @user = current_user
    @user.update_attributes(picture: user_params[:picture])
  end

  private
    def user_params
      params.require(:user).permit(:name,:picture,:description,:locality,:city,:portfolio)
    end
end
