module Presenters
  class Gauge < Base
    def data
      @data.first
    end
  end
end
