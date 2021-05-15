class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.bigint :order_id
      t.bigint :product_id
      t.integer :quantity

      t.timestamps
    end
  end
end
