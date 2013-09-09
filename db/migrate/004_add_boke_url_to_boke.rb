class AddBokeUrlToBoke < ActiveRecord::Migration
  def self.up
    change_table :bokes do |t|
      t.string :url
    end
  end

  def self.down
    change_table :bokes do |t|
      t.remove :url
    end
  end
end
