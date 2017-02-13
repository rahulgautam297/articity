require 'test_helper'

class UserSkillControllerTest < ActionDispatch::IntegrationTest
  test "should get user_skills" do
    get user_skill_user_skills_url
    assert_response :success
  end

end
