class AddAsyncFlagToQuery < ActiveRecord::Migration[5.0]
  def change
    add_column :queries, :async, :boolean, default: false
  end
end
