class RenameTitleColumnToBlogs < ActiveRecord::Migration[5.1]
  def change
    rename_column :blogs, :title, :name
  end
end
