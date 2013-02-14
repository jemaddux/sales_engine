require 'minitest/autorun'
require "./lib/transaction"
require "time"

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

end













