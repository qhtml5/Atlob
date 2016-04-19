class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string , unique: true , null: false
    add_column :users, :gender, :string , null: false
    add_column :users, :avatar, :string , null: false
    add_index :users, :name,                unique: true
    
  end
end