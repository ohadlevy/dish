class CreateOs < ActiveRecord::Migration
  def self.up
    create_table :os do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :os
  end
end
