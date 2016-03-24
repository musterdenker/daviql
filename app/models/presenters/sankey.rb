module Presenters
  class Sankey < Base

    def data
     data_table = GoogleVisualr::DataTable.new
        data_table.new_column('string', 'From')
        data_table.new_column('string', 'To')
        data_table.new_column('number', 'Sum')

        data_table.add_rows(@data.map{|e| [e['origin'],e['destination'],e['number']] } )
 #        [
 #          ['A', 'X', 5],
 #          ['A', 'Y', 7],
 #          ['A', 'Z', 6],
 #          ['B', 'X', 2],
 #          ['B', 'Y', 9],
 #          ['B', 'Z', 4]
 #        ]
 #      )

        opts   = { width: @layout[:width] }
        GoogleVisualr::Interactive::Sankey.new(data_table, opts)
    end

  end
end
