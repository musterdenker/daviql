class AddUserAccessRelation < ActiveRecord::Migration
  def self.up
    create_table :queries_users, :id => false do |t|
        t.references :query
        t.references :user
    end
    add_index :queries_users, [:query_id, :user_id]
    add_index :queries_users, [:user_id, :query_id]
  end

  def self.down
    drop_table :queries_users
  end
end
