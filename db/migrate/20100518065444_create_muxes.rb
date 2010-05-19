class CreateMuxes < ActiveRecord::Migration
  def self.up
    create_table :muxes, :id => false do |t|
      t.references :host, :null => false
      t.references :package, :null => false
      t.references :version, :null => false
      t.references :arch, :null => false
      t.references :os, :null => false
    end

    add_index :muxes, :host_id
    add_index :muxes, :package_id
    add_index :muxes, :version_id
    add_index :muxes, :os_id
    add_index :muxes, :arch_id
    add_index :muxes, [:host_id, :package_id]
    add_index :muxes, [:version_id, :package_id]
  end

  def self.down
    drop_table :muxes
  end
end
