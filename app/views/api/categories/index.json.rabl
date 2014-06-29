collection @categories

attributes :id, :name, :description

child(:items) do
  extends("api/items/index")
end
