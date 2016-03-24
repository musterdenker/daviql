module Presenters
  class Number < Base

    def data
      @data.first['number']
    end

  end
end
