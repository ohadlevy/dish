class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.column :name, :string
      t.timestamps
    end
    add_index :packages, :name
  end

  def self.down
    drop_table :packages
  end
end
