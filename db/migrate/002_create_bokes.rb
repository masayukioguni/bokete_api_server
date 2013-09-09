class CreateBokes < ActiveRecord::Migration
  def self.up
    create_table :bokes do |t|
      t.integer :bokete_id
      t.text :boke
      t.timestamps
    end
  end

  def self.down
    drop_table :bokes
  end
end
