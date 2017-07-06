class AddRentingPhaseIdToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_reference :invoices, :renting_phase, index: true
  end
end
