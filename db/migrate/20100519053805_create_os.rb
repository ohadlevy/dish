class CreateOs < ActiveRecord::Migration
  def self.up
    create_table :os do |t|
      t.string :name

      t.timestamps
    end
    add_index :os, :name
  end

  def self.down
    drop_table :os
  end
end
