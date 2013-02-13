require 'csv'

module GetCSV

	def get_csv(filename)
		csv_data = CSV.read filename
		headers = csv_data.shift.map {|i| i.to_sym }
		string_data = csv_data.map {|row| row.map {|cell| cell.to_s } }
		array_of_hashes = string_data.map {|row| Hash[*headers.zip(row).flatten] }
	end

end