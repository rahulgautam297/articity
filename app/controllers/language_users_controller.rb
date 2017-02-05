class LanguageUsersController < ApplicationController
  before_action :set_language_user, only: [:show, :edit, :update, :destroy]

  # GET /language_users
  # GET /language_users.json
  def index
    @language_users = LanguageUser.all
  end

  # GET /language_users/1
  # GET /language_users/1.json
  def show
  end

  # GET /language_users/new
  def new
    @language_user = LanguageUser.new
  end

  # GET /language_users/1/edit
  def edit
  end

  # POST /language_users
  # POST /language_users.json
  def create
    @language_user = LanguageUser.new(language_user_params)

    respond_to do |format|
      if @language_user.save
        format.html { redirect_to @language_user, notice: 'Language user was successfully created.' }
        format.json { render :show, status: :created, location: @language_user }
      else
        format.html { render :new }
        format.json { render json: @language_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /language_users/1
  # PATCH/PUT /language_users/1.json
  def update
    respond_to do |format|
      if @language_user.update(language_user_params)
        format.html { redirect_to @language_user, notice: 'Language user was successfully updated.' }
        format.json { render :show, status: :ok, location: @language_user }
      else
        format.html { render :edit }
        format.json { render json: @language_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /language_users/1
  # DELETE /language_users/1.json
  def destroy
    @language_user.destroy
    respond_to do |format|
      format.html { redirect_to language_users_url, notice: 'Language user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language_user
      @language_user = LanguageUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def language_user_params
      params.require(:language_user).permit(:language_id, :user_id, :level)
    end
end
