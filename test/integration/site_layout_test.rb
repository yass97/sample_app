require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  # test "header links" do
  #   get root_path
  #   assert_link(root_path, 2)
  #   assert_link(help_path)
  #   assert_link(login_path)

  #   log_in_as(@user)
  #   get root_path
  #   assert_link(root_path, 2)
  #   assert_link(help_path)
  #   assert_link(users_path)
  #   assert_link(user_path(@user), 3)
  #   assert_link(edit_user_path(@user))
  # end

  private
    def assert_link(path, count = 1)
      assert_select 'a[href=?]', path, count: count
    end
end
