class Contract < ApplicationRecord
  has_many :renting_phases

  def self.generate_contract(params, renting_phases)
    self.transaction do
      contract = self.create(params)
      if contract.save
        renting_phases.each do |renting_phase_param|
          contract.renting_phases.create(renting_phase_param)
        end

        contract
      else
        raise ActiveRecord::Rollback
      end
    end
  end

  def generate_invoices
    self.renting_phases.each do |phase|
      phase.generate_invoices
    end
  end

end
