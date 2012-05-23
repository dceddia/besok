class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
