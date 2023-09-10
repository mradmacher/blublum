class CreateLenses < ActiveRecord::Migration[7.0]
  def change
    create_table :lenses do |t|
      t.string :name
      t.text :description
      t.integer :lens_type
      t.integer :prescription_type
      t.integer :stock

      t.timestamps
    end
  end
end
