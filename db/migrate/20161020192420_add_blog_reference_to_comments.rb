class AddBlogReferenceToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :blog, foreign_key: true
  end
end
