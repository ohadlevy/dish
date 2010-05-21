class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.column :value, :string
      t.timestamps
    end
    add_index :versions, :value
  end

  def self.down
    drop_table :versions
  end
end
