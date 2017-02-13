class LanguageUsersController < ApplicationController
  before_action :set_language_user, only: [:show, :edit, :update, :destroy]
  before_action :check_language, only: [:update, :create]
  before_action :authenticate_user!, only: [:update, :create, :destroy]
  before_action :check_user, only: [:create]
  before_action :convert_to_number, only: [:update]
  # GET /language_users
  # # GET /language_users.json
  # def index
  #   @language_users = LanguageUser.all
  # end
  #
  # # GET /language_users/1
  # # GET /language_users/1.json
  # def show
  # end
  #
  # # GET /language_users/new
  # def new
  #   @language_user = LanguageUser.new
  # end
  #
  # # GET /language_users/1/edit
  # def edit
  # end

  # POST /language_users
  # POST /language_users.json
  def create
    @language_user = LanguageUser.new(language_user_params.except(:language,:language_user_id))
      if @language_user.save
        render json: {  id: @language_user[:id] }
      else
        render json: { errors: @language_user.errors }
      end
  end

  # PATCH/PUT /language_users/1
  # PATCH/PUT /language_users/1.json
  def update
    if @language_user.update_attributes(language_user_params.except(:language_user_id, :language, :user_id))
      render json: { status: :ok }
    else
      render json: {  errors: @language_user.errors }
    end
  end

  # DELETE /language_users/1
  # DELETE /language_users/1.json
  def destroy
    @language_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language_user
      @language_user = LanguageUser.find(language_user_params[:language_user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def language_user_params
      @language_user_params ||= params.require(:language_user).permit(:language, :language_id , :user_id, :level, :language_user_id)
    end
    def check_language
      @language_id = Language.find_by(name: language_user_params[:language])
      @language_user_params[:language_id] = @language_id[:id]
    end
    def check_user
      @user_id = session["warden.user.user.key"][0][0]
      @language_user_params[:user_id] = @user_id
    end
    def convert_to_number
      hash=LanguageUser.levels
      level=hash[language_user_params[:level]]
      @language_user_params[:level] = level
    end
end
