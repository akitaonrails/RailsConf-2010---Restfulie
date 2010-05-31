class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :name
      t.string :author
      t.string :image_uri
      t.float :price
      t.string :state
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :apps
  end
end
