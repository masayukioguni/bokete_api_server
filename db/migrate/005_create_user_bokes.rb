class CreateUserBokes < ActiveRecord::Migration
  def self.up
    create_table :user_bokes do |t|
      t.string :user_name
      t.integer :bokete_id
      t.string :boke
      t.string :image_url
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :user_bokes
  end
end
