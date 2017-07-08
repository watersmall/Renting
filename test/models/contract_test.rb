require 'test_helper'

class ContractTest < ActiveSupport::TestCase

  test "generate contract and invoices" do

    start_date = '2017-08-05'
    end_date = '2017-12-10'
    renting_phases = [
      { :start_date => '2017-08-05', :end_date => '2017-10-04', :price => 1300.00, :cycles => 1},
      { :start_date => '2017-10-05', :end_date => '2017-12-10', :price => 1800.00, :cycles => 1}
    ]

    contract_params = {
      :start_date => '2017-08-05',
      :end_date => '2017-12-10'
    }

    assert_difference(['Contract.count'], 1) do
      assert_difference(['RentingPhase.count'], 2) do
        contract = Contract.generate_contract(contract_params, renting_phases)
        contract.generate_invoices
        
        contract = contract.reload
        assert_equal contract.start_date.to_s, start_date
        assert_equal contract.end_date.to_s, end_date
        invoice_records = [
          ['2017-08-05'.to_date, '2017-09-04'.to_date, '2017-07-15'.to_date, 1300.00],
          ['2017-09-05'.to_date, '2017-10-04'.to_date, '2017-08-15'.to_date, 1300.00],
          ['2017-10-05'.to_date, '2017-11-04'.to_date, '2017-09-15'.to_date, 1800.00],
          ['2017-11-05'.to_date, '2017-12-04'.to_date, '2017-10-15'.to_date, 1800.00],
          ['2017-12-05'.to_date, '2017-12-10'.to_date, '2017-11-15'.to_date, (6*1800.00*12/365).round(2) ]
        ]

        assert_equal invoice_records, Invoice.all.pluck(:start_date, :end_date, :due_date, :total)
      end
    end
    
  end

end
