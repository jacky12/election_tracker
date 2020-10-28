class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.string :name
      t.integer :dem
      t.integer :gop
      t.references :state, null: false, foreign_key: true

      t.timestamps
    end
  end
end
