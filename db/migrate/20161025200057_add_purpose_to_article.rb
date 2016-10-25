class AddPurposeToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :purpose, :string
  end
end
