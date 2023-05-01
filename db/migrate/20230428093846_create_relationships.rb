class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 複合キーインデックス。follower_id と followed_id の組み合わせがユニークであることを保証する
    # 同じユーザーを2回以上フォローするのを防ぐ
    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
