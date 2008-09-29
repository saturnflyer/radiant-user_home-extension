class AddUserHome < ActiveRecord::Migration
  def self.up
    add_column :users, :home_path, :string, :default => '/admin/pages'
  end
  def self.down
    remove_column :users, :home_path
  end
end