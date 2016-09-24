class CreateBloggers < ActiveRecord::Migration[5.0]
  def change
    create_table :bloggers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
