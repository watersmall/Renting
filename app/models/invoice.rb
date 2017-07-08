class Invoice < ApplicationRecord
  has_many :line_items
  belongs_to :renting_phase

  before_create :cal_total

  def cal_duration
    the_duration = {}
    if self.start_date.day - self.end_date.day == 1
      the_duration[:month] =  self.end_date.month - self.start_date.month
      the_duration[:day] = 0
    else
      the_duration[:month] =  self.end_date.month - self.start_date.month - (self.start_date.day >= self.end_date.day ? 1 : 0)
      the_duration[:day] =  (self.end_date - the_duration[:month].month).day - self.start_date.day + 1
    end
    the_duration
  end
    
  def cal_total
    the_duration = cal_duration
    price_per_month = self.renting_phase.price
    self.total = price_per_month * the_duration[:month] + the_duration[:day] * price_per_month * 12 / 365
  end
end
