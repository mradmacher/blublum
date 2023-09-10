class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :client
      t.references :frame
      t.references :lens
      t.float :price
      t.string :currency

      t.timestamps
    end
  end
end
