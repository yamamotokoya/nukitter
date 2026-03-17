require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm_age" do
    get welcome_confirm_age_url
    assert_response :success
  end
end
