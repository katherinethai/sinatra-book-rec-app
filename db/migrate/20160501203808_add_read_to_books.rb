class AddReadToBooks < ActiveRecord::Migration
  def change
    add_column :books, :read, :boolean, default: false
  end
end
