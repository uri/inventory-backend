object @item

attributes :id, :name, :description, :category_id

node :errors do |item|
  item.errors
end