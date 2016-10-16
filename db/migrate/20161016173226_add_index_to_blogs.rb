class AddIndexToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_index :blogs, :created_at
  end
end
