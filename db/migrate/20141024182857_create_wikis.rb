class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :description
      t.boolean :private, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end