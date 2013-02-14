require './lib/get_csv_mod'
# run the csv import in sales_engine.rb

class Merchant
  extend GetCSV

  attr_accessor :id, :name, :created_at, :updated_at

  def self.new_merchants(data_file)
    data_dump = get_csv(data_file)

    @merchants_list = []
    data_dump.each do |merchant|
      new_merchant = Merchant.new(merchant)
      @merchants_list << new_merchant
    end
  end

  def initialize(merchant)
    @id = merchant[:id]
    @name = merchant[:name]
    @created_at = merchant[:created_at]
    @updated_at = merchant[:updated_at]
  end

end