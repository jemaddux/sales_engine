#require 'simplecov'
#SimpleCov.start
#require 'minitest/autorun'
require "sales_engine/merchant"
#require 'minitest/pride'
#require './sales_engine'
require_relative 'support'

module SalesEngine
  class MerchantTest < MiniTest::Unit::TestCase

    def test_hash_favorite_customer_customer_who_has_most_successful_transactions
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[84]
      favorite_customer = merchant.favorite_customer
      assert_equal Customer, favorite_customer.class
      assert_equal 715, favorite_customer.id
      assert_equal "Hailey", favorite_customer.first_name
    end

    def test_hash_customers_with_pending_invoices_returns_array_of_customer_instances
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[95]
      customer_list = merchant.customers_with_pending_invoices
      customer = customer_list[0]
      assert_equal Array, customer_list.class
      assert_equal Customer, customer.class
      assert_equal 876, customer.id
    end

    def test_revenue_date_returns_total_revenue_for_date_across_all_merchants
      SalesEngine.startup
      total_rev1 = Merchant.revenue("2012-03-27 14:54:01 UTC")
      total_rev2 = Merchant.revenue("2012-03-28 14:54:01 UTC")
      assert_equal 1908368.05, total_rev1.to_f
      assert_equal 0, total_rev2.to_f
    end

    def test_hash_revenue_date_returns_the_total_revenue_for_that_merchant_for_invoice_date
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[23]
      mer_rev_normal = merchant.revenue
      mer_rev = merchant.revenue("2012-03-27 14:54:01 UTC")
      merchant2 = Merchant.list_of_merchants[42]
      mer2_rev_normal = merchant2.revenue
      mer2_rev = merchant2.revenue("2012-03-27 14:54:01 UTC")
      assert_equal 9335.07, mer_rev.to_f
      assert_equal 413122.69, mer_rev_normal.to_f
      assert_equal 19018.35, mer2_rev.to_f
      assert_equal 582928.72, mer2_rev_normal.to_f
    end

    def test_merchant_most_revenueX_returns_a_list_of_merchant_instances_sorted_by_revenue
      SalesEngine.startup
      list = Merchant.most_revenue(10)
      best_merchant = list[0]
      merchant1 = list[1]
      merchant2 = list[2]
      merchant3 = list[3]
      merchant4 = list[4]
      assert_kind_of Array, list
      assert_equal 1148393.74, best_merchant.how_much_rev.to_f
      assert_equal "Dicki-Bednar", best_merchant.name
      assert_equal 1015275.15, merchant1.how_much_rev.to_f
      assert_equal 917424.86, merchant2.how_much_rev.to_f
      assert_equal 831493.84, merchant3.how_much_rev.to_f
      assert_equal 829597.18, merchant4.how_much_rev.to_f
    end

    def test_that_remove_bad_transactions_works
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[23]
      mer_ids = merchant.merchant_invoices(merchant.id)
      new_mer_ids = merchant.bad_transactions(mer_ids, merchant.id)
      assert_equal 1, new_mer_ids.size
      assert_equal 4769, new_mer_ids[0]
    end

    def test_that_merchant_invoices_works
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[23]
      mer_ids = merchant.merchant_invoices(merchant.id)
      num_ids = mer_ids.size
      assert_equal 38, num_ids
      assert_equal 179, mer_ids[0]
      assert_equal 187, mer_ids[1]
      assert_equal 381, mer_ids[2]
      assert_equal 517, mer_ids[3]
      assert_equal 683, mer_ids[5]
      assert_equal 1218, mer_ids[12]
      assert_equal 4775, mer_ids[37]
    end

  ############################################################

    def test_merchant_most_itemsX_returns_a_list_of_merchant_instances_sorted_by_num_of_items
      SalesEngine.startup
      list = Merchant.most_items(10)
      best_merchant = list[0]
      assert_kind_of Array, list
      assert_equal 1662, best_merchant.num_items
    end

    def test_merchant_instance_has_attr_accessor_num_items
      SalesEngine.startup
      merchants = Merchant.list_of_merchants
      assert merchants[0].respond_to?(:num_items)
      assert merchants[23].respond_to?(:num_items)
      assert merchants[42].respond_to?(:num_items) 
      assert merchants[64].respond_to?(:num_items)
      assert merchants[78].respond_to?(:num_items)
      assert merchants[99].respond_to?(:num_items)
    end

    def test_merchant_most_itemsX_returns_a_list_of_merchant_instances
      SalesEngine.startup
      list = Merchant.most_items(10)
      list.each do |merchant|
        assert_kind_of Merchant, merchant
      end
    end

    def test_merchant_most_itemsX_returns_X_merchants
      SalesEngine.startup
      list = Merchant.most_items(10)
      assert_equal 9, list.size
      assert_kind_of Array, list
    end

    #######################################################################



    def test_that_merchant_hash_revenue_returns_the_right_revenue
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[23]
      mer = Merchant.list_of_merchants[3]
      merch = Merchant.list_of_merchants[73]
      assert_equal BigDecimal('413122.69'), merchant.revenue
      assert_equal 558055.22, mer.revenue.to_f
      assert_equal 474473.08, merch.revenue.to_f
    end

    # def test_that_merchant_hash_revenue_returns_a_big_decimal
    #   SalesEngine.startup
    #   merchant = Merchant.list_of_merchants[12]
    #   assert_equal BigDecimal, merchant.revenue.class
    # end

    # def test_that_successful_invoices_returns_a_merchants_successfully_billed_invoices
    #   SalesEngine.startup
    #   merchant = Merchant.list_of_merchants[45]
    #   invoices = merchant.successful_invoices
    #   assert_equal 50, invoices.size
    #   assert_equal "46", invoices[4].merchant_id
    # end

    # def test_that_successful_transactions_on_a_merchant_instance_returns_an_array_of_successful_transactions_instances
    #   SalesEngine.startup
    #   merchant = Merchant.list_of_merchants[45]
    #   success_array = merchant.successful_transactions
    #   assert_equal 50, success_array.size
    # end

    def test_that_all_invoice_instances_for_a_merchant_instance_returns_an_array_of_instances
      SalesEngine.startup
      merchant = Merchant.list_of_merchants[27]
      invoice_instances = Invoice.find_all_by_merchant_id(merchant.id)
      assert_equal Array, invoice_instances.class
      assert_equal 45, invoice_instances.size
      assert_equal Invoice, invoice_instances[3].class
    end

  #################################################################

  	def test_get_csv_loads_data
  		merchant_file = "./test/sample/merchants.csv"
  		file_contents = Merchant.get_csv(merchant_file)
  		assert_operator file_contents.size, :>= , 5
  	end

    #def test_convert_time_strings_to_date_objects

    def test_that_we_can_get_a_merchant_id_from_an_instance
      merchant = Merchant.new(:id => "1")
      assert_equal 1, merchant.id
    end

    def test_that_we_can_get_a_merchant_name_from_an_instance
      merchant = Merchant.new(:name => "Mike")
      assert_equal "Mike", merchant.name
    end

    def test_that_we_can_get_a_merchant_created_date_from_an_instance
      time = Time.now
      merchant = Merchant.new(:created_at => time)
      assert_equal time, merchant.created_at
    end

    def test_that_we_can_get_a_merchant_updated_date_from_an_instance
      time = Time.now
      merchant = Merchant.new(:updated_at => time)
      assert_equal time, merchant.updated_at
    end

    def test_that_we_can_create_merchant_objects_using_simulated_data
      single_merchant = {
        :id => "1",
        :name => "Mike, Smith",
        :created_at => "2012-03-27 14:53:59 UTC",
        :updated_at => "2012-03-27 14:53:59 UTC"
      }
      assert_kind_of Merchant, Merchant.new(single_merchant)
    end

    def test_that_calling_new_merchants_returns_an_array
      merchant_list = Merchant.make_merchants(true)
      assert_equal Array, merchant_list.class
    end

    def test_merchant_returns_an_array_when_items_is_called_on_an_instance
      Merchant.make_merchants
      merchant = Merchant.list_of_merchants[42]
      assert_equal Array, merchant.items.class
    end

    def test_merchant_has_right_items_when_called
      Merchant.make_merchants(true)#true for testing
      first_merchant = Merchant.list_of_merchants[0]
      item_hash = {id: "1", name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id: "1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"}
      item = Item.new(item_hash)
      Merchant.add_relationships
      assert_equal Item, first_merchant.items[0].class
    end  

    def test_merchant_can_find_items_by_merchant_id
      Merchant.make_merchants(true)#true for testing
      Item.make_items(true)
      Merchant.add_relationships
      first_merchant = Merchant.list_of_merchants[0]
      item_hash = {id: "1", name: "Item Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.", unit_price: "75107", merchant_id: "1", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC"}
      item = Item.new(item_hash)
      assert_equal first_merchant.items[0].name, item.name
    end

    def test_merchant_can_find_items_by_merchant_id_in_real_data
      SalesEngine.startup
      Merchant.make_merchants
      Item.make_items
      Merchant.add_relationships
      merchant = Merchant.list_of_merchants[3]  
      assert_equal Item, merchant.items[0].class
    end

    def test_merchants_returns_an_array_when_invoices_is_called_on_an_instance
      SalesEngine.startup
      Merchant.make_merchants
      merchant = Merchant.list_of_merchants[23]
      assert_equal Array, merchant.invoices.class
    end

    def test_merchant_responds_to_find_by_id
      assert Merchant.respond_to?(:find_by_id) 
    end

    def test_merchant_responds_to_find_by_name
      assert Merchant.respond_to?(:find_by_name)
    end

    def test_merchant_responds_to_find_by_created_at
      assert Merchant.respond_to?(:find_by_created_at)
    end

    def test_merchant_responds_to_find_by_updated_at
      assert Merchant.respond_to?(:find_by_updated_at)
    end

    def test_merchant_responds_to_find_by_items
      assert Merchant.respond_to?(:find_by_items)
    end

    def test_merchant_responds_to_find_by_invoices
      assert Merchant.respond_to?(:find_by_invoices)
    end

    def test_merchant_responds_to_find_all_by_id
      assert Merchant.respond_to?(:find_all_by_id)
    end

    def test_merchant_responds_to_find_all_by_name
      assert Merchant.respond_to?(:find_all_by_name)
    end

    def test_merchant_responds_to_find_all_by_created_at
      assert Merchant.respond_to?(:find_all_by_created_at)
    end

    def test_merchant_responds_to_find_all_by_updated_at
      assert Merchant.respond_to?(:find_all_by_updated_at)
    end

    def test_merchant_responds_to_find_all_by_items
      assert Merchant.respond_to?(:find_all_by_items)
    end

    def test_merchant_responds_to_find_all_by_invoices
      assert Merchant.respond_to?(:find_all_by_invoices)
    end

  ################################################

    def test_merchant_find_by_name_returns_the_correct_name
      Merchant.make_merchants(true)#true for testing, false by default
      merchant = Merchant.find_by_name("Hand-Spencer")
      assert_equal "Hand-Spencer", merchant.name
    end  

    def test_merchant_find_by_id_returns_the_correct_id
      Merchant.make_merchants(true)#true for testing, false by default
      merchant = Merchant.find_by_id(3)
      assert_equal 3, merchant.id
    end  

    def test_merchant_find_by_created_at_returns_the_correct_created_at
      Merchant.make_merchants(true)#true for testing, false by default
      merchant = Merchant.find_by_created_at("2012-03-27 14:53:59 UTC")
      assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
    end

    def test_merchant_find_by_updated_at_returns_the_correct_time
      Merchant.make_merchants(true)#true for testing, false by default
      merchant = Merchant.find_by_updated_at("2012-03-27 14:53:59 UTC")
      assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
    end  

  ############################################

    def test_merchant_find_all_by_name_returns_the_count
      Merchant.make_merchants(true)#true for testing, false by default
      merchants = Merchant.find_all_by_name("Bechtelar, Jones and Stokes")
      assert_equal 7, merchants.count
    end  

    def test_merchant_find_all_by_id_returns_the_count
      Merchant.make_merchants(true)#true for testing, false by default
      merchants = Merchant.find_all_by_id(3)
      assert_equal 1, merchants.count
    end  

    def test_merchant_find_all_by_created_at_returns_the_correct_amount
      Merchant.make_merchants(true)#true for testing, false by default
      merchants = Merchant.find_all_by_created_at("2012-03-27 14:54:00 UTC")
      assert_equal 7, merchants.count
    end

    def test_merchant_find_all_by_updated_at_returns_the_correct_time
      Merchant.make_merchants(true)#true for testing, false by default
      merchants = Merchant.find_all_by_updated_at("2012-03-27 14:54:00 UTC")
      assert_equal 7, merchants.count
    end  

  ###################################################
    def test_merchant_hash_invoices_returns_an_array_collection_of_invoice_instances
      SalesEngine.startup
      Merchant.make_merchants
      merchant = Merchant.list_of_merchants[42] 
      assert_equal Array, merchant.invoices.class
    end

    def test_merchant_hash_invoices_returns_the_correct_array_full_of_invoice_instances
      SalesEngine.startup
      Merchant.make_merchants
      merchant = Merchant.list_of_merchants[1] 
      invoice = merchant.invoices[0]
      assert_equal "shipped", invoice.status
    end
  end
end