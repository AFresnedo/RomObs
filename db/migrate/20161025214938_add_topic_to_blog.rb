class AddTopicToBlog < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :topic, :string
  end
end
