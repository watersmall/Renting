class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.date :start_date
      t.date :end_date
      t.date :due_date
      t.decimal :total, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
