require 'test_helper'

class LanguageUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @language_user = language_users(:one)
  end

  test "should get index" do
    get language_users_url
    assert_response :success
  end

  test "should get new" do
    get new_language_user_url
    assert_response :success
  end

  test "should create language_user" do
    assert_difference('LanguageUser.count') do
      post language_users_url, params: { language_user: { language_id: @language_user.language_id, level: @language_user.level, user_id: @language_user.user_id } }
    end

    assert_redirected_to language_user_url(LanguageUser.last)
  end

  test "should show language_user" do
    get language_user_url(@language_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_language_user_url(@language_user)
    assert_response :success
  end

  test "should update language_user" do
    patch language_user_url(@language_user), params: { language_user: { language_id: @language_user.language_id, level: @language_user.level, user_id: @language_user.user_id } }
    assert_redirected_to language_user_url(@language_user)
  end

  test "should destroy language_user" do
    assert_difference('LanguageUser.count', -1) do
      delete language_user_url(@language_user)
    end

    assert_redirected_to language_users_url
  end
end
