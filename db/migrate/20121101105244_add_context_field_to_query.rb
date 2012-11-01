class AddContextFieldToQuery < ActiveRecord::Migration
  def change
  	add_column :queries, :context, :string
  end
end
