require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "./lib/transaction"
require "time"
require 'minitest/pride'

class TransactionTest < MiniTest::Unit::TestCase
  def test_it_exists
    transaction = Transaction.new({})
    assert_kind_of Transaction, transaction
  end

  def test_get_csv_loads_data
    transaction_file = "./test/sample/transactions.csv"
    file_contents = Transaction.get_csv(transaction_file)
    assert_operator file_contents.size, :>= , 5
  end

  def test_transaction_has_id
    transaction = Transaction.new({id: "4"})
    assert_equal "4", transaction.id
  end

  def test_transaction_has_invoice_id
    transaction = Transaction.new({invoice_id: "42"})
    assert_equal "42", transaction.invoice_id
  end

  def test_transaction_has_credit_card_number
    transaction = Transaction.new({:credit_card_number => "111111222222333333"})
    assert_equal "111111222222333333", transaction.credit_card_number
  end

  def test_transaction_has_created_at_time
    time_obj = Time.now
    transaction = Transaction.new({created_at: time_obj})
    assert_equal time_obj, transaction.created_at
  end

  def test_transaction_has_upadated_at_time
    time_obj = Time.now
    transaction = Transaction.new({updated_at: time_obj})
    assert_equal time_obj, transaction.updated_at
  end

  def test_can_create_an_array_of_transactions_from_sample_transactions_csv
    Transaction.make_transactions(true)#true for testing
    @list_of_transactions = Transaction.list_of_transactions 
    assert_equal Array, @list_of_transactions.class
  end

  def test_can_create_a_transaction_instance_from_sample_transactions_csv
    Transaction.make_transactions(true)#true for testing, false by default
    @list_of_transactions = Transaction.list_of_transactions
    assert_kind_of Transaction, @list_of_transactions[0]
  end

  def test_can_create_a_transaction_with_the_right_id
    Transaction.make_transactions(true)#true for testing, false by default
    @list_of_transactions = Transaction.list_of_transactions
    assert_equal "1", @list_of_transactions[0].id
  end

  def test_that_calling_invoice_on_an_instance_of_transaction_returns_an_instance_of_invoice
    Transaction.make_transactions
    transaction = Transaction.list_of_transactions[2]
    assert_equal Invoice, transaction.invoice.class    
  end

##############Respond to Tests###################

  def test_Transaction_responds_to_find_by_id
    assert Transaction.respond_to?(:find_by_id) 
  end

  def test_Transaction_responds_to_find_by_created_at
    assert Transaction.respond_to?(:find_by_created_at)
  end

  def test_Transaction_responds_to_find_by_updated_at
    assert Transaction.respond_to?(:find_by_updated_at)
  end

  def test_Transaction_responds_to_find_by_invoice_id
    assert Transaction.respond_to?(:find_by_invoice_id)
  end

  def test_Transaction_responds_to_find_by_invoice
    assert Transaction.respond_to?(:find_by_invoice)
  end

  def test_Transaction_responds_to_find_by_credit_card_number
    assert Transaction.respond_to?(:find_by_credit_card_number)
  end

  def test_Transaction_responds_to_find_by_credit_card_expiration_date
    assert Transaction.respond_to?(:find_by_credit_card_expiration_date)
  end

  def test_Transaction_responds_to_find_by_result
    assert Transaction.respond_to?(:find_by_result)
  end

  def test_Transaction_responds_to_find_all_by_id
    assert Transaction.respond_to?(:find_all_by_id)
  end

  def test_Transaction_responds_to_find_all_by_created_at
    assert Transaction.respond_to?(:find_all_by_created_at)
  end

  def test_Transaction_responds_to_find_all_by_updated_at
    assert Transaction.respond_to?(:find_all_by_updated_at)
  end

  def test_Transaction_responds_to_find_all_by_invoice_id
    assert Transaction.respond_to?(:find_all_by_invoice_id)
  end

  def test_Transaction_responds_to_find_all_by_invoice
    assert Transaction.respond_to?(:find_all_by_invoice)
  end

  def test_Transaction_responds_to_find_all_by_credit_card_number
    assert Transaction.respond_to?(:find_all_by_credit_card_number)
  end

  def test_Transaction_responds_to_find_all_by_credit_card_expiration_date
    assert Transaction.respond_to?(:find_all_by_credit_card_expiration_date)
  end

  def test_Transaction_responds_to_find_all_by_result
    assert Transaction.respond_to?(:find_all_by_result)
  end

################################################

  def test_transaction_find_by_id_returns_the_correct_id
    Transaction.make_transactions(true)#true for testing, false by default
    transaction = Transaction.find_by_id("3")
    assert_equal "3", transaction.id
  end  

  def test_transaction_find_by_created_at_returns_the_correct_created_at
    Transaction.make_transactions(true)#true for testing, false by default
    transaction = Transaction.find_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", transaction.created_at
  end

  def test_transaction_find_by_updated_at_returns_the_correct_time
    Transaction.make_transactions(true)#true for testing, false by default
    transaction = Transaction.find_by_updated_at("2012-03-27 14:54:10 UTC")
    assert_equal "2012-03-27 14:54:10 UTC", transaction.updated_at
  end  

############################################

  def test_transaction_find_all_by_id_returns_the_count
    Transaction.make_transactions(true)#true for testing, false by default
    transactions = Transaction.find_all_by_id("3")
    assert_equal 1, transactions.count
  end  

  def test_transaction_find_all_by_created_at_returns_the_correct_amount
    Transaction.make_transactions(true)#true for testing, false by default
    transactions = Transaction.find_all_by_created_at("2012-03-27 14:54:10 UTC")
    assert_equal 17, transactions.count
  end

  def test_transaction_find_all_by_updated_at_returns_the_correct_time
    Transaction.make_transactions(true)#true for testing, false by default
    transactions = Transaction.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal 2, transactions.count
  end

  def test_invoice_instance_method_returns_an_instance
    transaction = Transaction.new({:invoice_id => "7"})
    invoices = Invoice.make_invoices(true)
    assert_kind_of Invoice, transaction.invoice
  end

  def test_invoice_instance_method_returns_the_right_instance
    transaction = Transaction.new({:invoice_id => "7"})
    invoices = Invoice.make_invoices(true)
    invoice = transaction.invoice
    assert_equal "7", invoice.id
  end

  def test_successful_transactions_returns_an_array
    Transaction.make_transactions
    assert_kind_of Array, Transaction.successful_transactions
  end

  def test_successful_transactions_returns_only_successful_transactions
    Transaction.make_transactions(true)
    successful_transactions = Transaction.successful_transactions
    successful_transactions.each do |transaction|
      assert_equal "success", transaction.result
    end
  end

  def test_successful_transaction_invoice_ids_returns_an_array
    Transaction.make_transactions(true)
    assert_kind_of Array, Transaction.successful_transaction_invoice_ids
  end
end
