class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :ip_address
      t.string :user_agent
      t.string :referer
      t.integer :token_id

      t.timestamps
    end
  end
end
