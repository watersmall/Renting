class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :unit_price, :precision => 10, :scale => 2
      t.decimal :total, :precision => 10, :scale => 2
      t.integer :units
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
