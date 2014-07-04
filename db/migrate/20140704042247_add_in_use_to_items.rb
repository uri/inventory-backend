class AddInUseToItems < ActiveRecord::Migration
  def change
    add_column :items, :in_use, :boolean
  end
end
