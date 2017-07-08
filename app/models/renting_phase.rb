class RentingPhase < ApplicationRecord
  belongs_to :contract
  has_many :invoices

  def generate_invoices
    self.time_split.each do |invoice_date_range|
      invoice_params = {
        :start_date => invoice_date_range.first,
        :end_date => invoice_date_range.last,
        :due_date => invoice_date_range.first.last_month.beginning_of_month + 14.day,
      }
      invoice = self.invoices.create(invoice_params)
      invoice.save
    end
  end

  def time_split
    invoices_start_date = []
    remain_time_start = self.start_date
    while remain_time_start <=  self.end_date  do
      invoice_end_date = (remain_time_start + self.cycles.month - 1.day)
      invoice_end_date = invoice_end_date <= self.end_date ? invoice_end_date : self.end_date
      invoices_start_date.push([remain_time_start, invoice_end_date])
      remain_time_start = invoice_end_date + 1.day
    end
    invoices_start_date
  end
end
