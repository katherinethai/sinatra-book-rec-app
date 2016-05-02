class AddGenreAndAuthorColumnsToBooksTable < ActiveRecord::Migration
  def change
    add_column :books, :genre, :string
    add_column :books, :author, :string
  end
end
