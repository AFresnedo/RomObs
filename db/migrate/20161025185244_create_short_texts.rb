class CreateShortTexts < ActiveRecord::Migration[5.0]
  def change
    create_table :short_texts do |t|
      t.string :body
      t.string :page

      t.timestamps
    end
  end
end
