class AddHeightWidthToQueries < ActiveRecord::Migration[5.0]
  def change
    add_column :queries, :width, :integer
    add_column :queries, :height, :integer
  end
end
