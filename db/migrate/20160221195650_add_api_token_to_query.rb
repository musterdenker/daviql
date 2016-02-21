class AddApiTokenToQuery < ActiveRecord::Migration[5.0]
  def change
    add_column :queries, :auth_token, :string
  end
end
