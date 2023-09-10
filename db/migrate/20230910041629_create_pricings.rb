class CreatePricings < ActiveRecord::Migration[7.0]
  def change
    create_table :pricings do |t|
      t.float :usd
      t.float :gbp
      t.float :eur
      t.float :jod
      t.float :jpy
      t.bigint :priceable_id
      t.string :priceable_type

      t.timestamps
    end

    add_index :pricings, [:priceable_id, :priceable_type]
  end
end
