class CreateEcommerceEntries < ActiveRecord::Migration
  def change
    create_table :ecommerce_entries do |t|
      t.string :content
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
