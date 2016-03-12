module Presenters
  class Base
    def initialize(query, data, layout)
      @data = data
      @query = query
      @layout = layout
    end
    def data
      @data
    end
  end
end