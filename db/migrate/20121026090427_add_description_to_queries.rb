class AddDescriptionToQueries < ActiveRecord::Migration
  def change
  	add_column :queries, :description, :text
  end
end
