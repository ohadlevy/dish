class CreateArches < ActiveRecord::Migration
  def self.up
    create_table :arches do |t|
      t.string :name

      t.timestamps
    end
    add_index :arches, :name
  end

  def self.down
    drop_table :arches
  end
end
