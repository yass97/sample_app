require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    user = {
      name: "",
      email: "user@invalid",
      password: "foo",
      password_confirmation: "bar"
    }

    assert_no_difference "User.count" do post users_path, params: { user: user } end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.alert"
  end

  test "valid signup information" do
    get signup_path
    user = { name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password" }
    assert_difference "User.count", 1 do post users_path, params: { user: user }
    end
    follow_redirect!
    assert_template "users/show"
    assert is_logged_in?
  end
end
