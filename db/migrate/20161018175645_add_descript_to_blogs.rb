class AddDescriptToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :descript, :string
  end
end
