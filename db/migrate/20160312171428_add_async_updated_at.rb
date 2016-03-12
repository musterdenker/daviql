class AddAsyncUpdatedAt < ActiveRecord::Migration[5.0]
  def change
    add_column :queries, :async_updated_at, :datetime
  end
end
