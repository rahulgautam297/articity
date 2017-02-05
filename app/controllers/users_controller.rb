class UsersController < Devise::RegistrationsController


  private
    def user_params
      params.require(:user).permit(:name,:picture,:description,:college,:locality,:state,:portfolio,:mobile)
    end
end
