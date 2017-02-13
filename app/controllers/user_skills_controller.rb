class UserSkillsController < ApplicationController
  before_action :set_user_skill,     only: [:destroy, :update]
  before_action :user_skill_params,  only: [:user_skills, :update]
  before_action :authenticate_user!, only: [:user_skills,:destroy,:update]
  before_action :check_user,         only: [:user_skills]
  before_action :add_skill_id,       only: [:update]

  def user_skills
    @user_skill = UserSkill.new(user_skill_params.except(:user_skill_id, :name))
    if @user_skill.save
      render json: {  id: @user_skill[:id], multimedia: @user_skill[:multimedia] }
    else
      render json: { errors: @user_skill.errors }
    end
  end

  def update
    if @user_skill.update_attributes(user_skill_params.except(:user_skill_id, :user_id, :name))
      render json: { status: :ok }
    else
      render json: {  errors: @user_skill.errors }
    end
  end

  def destroy
    @user_skill.destroy
  end

  private
      # Use callbacks to share common setup or constraints between actions.
      def set_user_skill
        @user_skill = UserSkill.find_by(id: user_skill_params[:user_skill_id])
      end
      def user_skill_params
        @user_skill_params ||= params.require(:user_skill).permit(:skill_id,:user_id,:name,:portfolio,:price,:description,:multimedia,:user_skill_id)
      end
      def check_user
        @user_id = session["warden.user.user.key"][0][0]
        @user_skill_params[:user_id] = @user_id
      end
      def add_skill_id
        @skill_id = Skill.find_by(name: user_skill_params[:name])
        @user_skill_params[:skill_id] = @skill_id[:id]
      end
end
