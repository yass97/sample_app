require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "following page" do
    # フォロー中のユーザー一覧ページを取得
    get following_user_path(@user)
    # フォローしているユーザーが存在することを確認
    assert_not @user.following.empty?
    # フォロー件数がレスポンスに含まれていることを確認
    assert_match @user.following.count.to_s, response.body
    # フォロー一覧のアイテムが、ユーザーの詳細ページへのリンクになっていることを確認
    @user.following.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      # assert_select "a[href=?]", user_path(user)
    end
  end
end
