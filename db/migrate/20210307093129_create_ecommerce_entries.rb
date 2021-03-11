class CreateEcommerceEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :ecommerce_entries do |t|
      t.string :title
      t.integer :price
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
