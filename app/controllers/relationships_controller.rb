class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    # フォローするユーザーを取得
    @user = User.find(params[:followed_id])
    # ユーザーをフォロー
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    # フォローされているユーザーを取得
    @user = Relationship.find(params[:id]).followed
    # フォロー解除
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
