class PopulateCategoriesWithSampleRecords < ActiveRecord::Migration
  def up
    category_names = [
      'Audio',
      'AV - Misc',
      'Computers',
      'Camera',
      'Electronics',
      'Rooms',
      'Projectors',
      'Cables'
    ]

    category_names.each do |name|
      Category.create(name: name)
    end
  end

  def down
    Category.delete_all
  end
end
