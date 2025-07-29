class AddIndexToMicropostsUserIdAndCreatedAt < ActiveRecord::Migration[7.0]
  def change
    add_index :microposts, %i(user_id created_at)
  end
end
