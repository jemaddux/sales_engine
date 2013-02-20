module SalesEngine
  module Searching

    def random
      data.sample
    end

    def find_by(attribute, match)
      data.detect{|instance| instance.send(attribute).to_s.downcase == match.to_s.downcase}
    end

    def find_all_by(attribute, match)
      data.select{|instance| instance.send(attribute) == match.to_s}
    end

  end
end
