class AddDefaultValueToBloggerInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :blogger, :boolean, default: false
  end
end
