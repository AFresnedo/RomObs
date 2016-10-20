class AddMultiKeyIndexToComments < ActiveRecord::Migration[5.0]
  def change
    remove_index :comments, :blog_id
    remove_index :comments, :created_at
    add_index :comments, [:blog_id, :created_at]
  end
end
