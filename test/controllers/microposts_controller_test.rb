require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Micropost.count" do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "Micropost.count" do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong micropost" do
    # michael でログイン
    log_in_as(users(:michael))
    # ants の投稿を取得
    micropost = microposts(:ants)
    # ants の投稿を michael で削除しようとするが、ants の投稿件数が変わらないことを確認する
    assert_no_difference "Micropost.count" do
      delete micropost_path(micropost)
    end
    # 削除に失敗したあと、ホーム画面へリダイレクトすることを確認
    assert_redirected_to root_url
  end
end
