require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select 'div.alert', count: 1
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'
    user = {
      name: name,
      email: email,
      password: '',
      password_confirmation: ''
    }
    patch user_path(@user), params: { user: user }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  # 未認証で編集ページを開いて認証したあとに、編集ページが表示されることを確認する
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    user = {
      name: name,
      email: email,
      password: "",
      password_confirmation: ""
    }
    patch user_path(@user), params: { user: user }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  # 未認証で編集ページへアクセス > 認証 > 編集ページ表示、認証 > ユーザーページが表示されることを確認する
  test "show user page when login after edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)

    delete logout_path
    log_in_as(@user)
    assert_redirected_to user_path(@user)
  end
end
