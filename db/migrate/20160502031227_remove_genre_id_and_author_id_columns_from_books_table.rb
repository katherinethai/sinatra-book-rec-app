class RemoveGenreIdAndAuthorIdColumnsFromBooksTable < ActiveRecord::Migration
  def change
    remove_column :books, :genre_id
    remove_column :books, :author_id
  end
end
