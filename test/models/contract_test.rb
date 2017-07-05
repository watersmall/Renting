require 'test_helper'

class ContractTest < ActiveSupport::TestCase

  test "generate contract and invoices" do
    start_date = '2017-08-05'
    end_date = '2017-12-10'
    price = 1300.00
    cycles = 2
    assert_difference(['Contract.count'], 1) do
      assert_difference(['RentingPhase.count'], 2) do
        contract = Contract.generate_contract(start_date, end_date, price, cycles)
        invoices = contract.generate_invoices

        contract = contract.reload
        assert_equal contract.start_date.to_s, start_date
        assert_equal contract.end_date.to_s, end_date

      end
    end

    start_date = '2017-08-05'
    end_date = '2017-12-10'
    price = 1300.00
    cycles = 1
    assert_difference(['Contract.count'], 1) do
      assert_difference(['RentingPhase.count'], 5) do
        contract = Contract.generate_contract(start_date, end_date, price, cycles)
        invoices = contract.generate_invoices

        contract = contract.reload
        assert_equal contract.start_date.to_s, start_date
        assert_equal contract.end_date.to_s, end_date

      end
    end
    
  end

end
