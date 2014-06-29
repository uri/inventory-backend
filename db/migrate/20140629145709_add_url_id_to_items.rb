class AddUrlIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :url_id, :string
  end
end
