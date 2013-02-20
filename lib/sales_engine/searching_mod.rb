module SalesEngine
  module Searching

    def random
      data.sample
    end

    def find_by(attribute, match)
      data.detect{|instance| instance.send(attribute) == match}
    end

    def find_all_by(attribute, match)
      data.select{|instance| instance.send(attribute) == match}
    end

  end
end
