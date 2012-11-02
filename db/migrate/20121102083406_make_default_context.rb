class MakeDefaultContext < ActiveRecord::Migration
  def up
  	change_column :queries, :context, :string, :default => ""
  end

  def down
  end
end
