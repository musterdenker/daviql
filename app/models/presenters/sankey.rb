module Presenters
  class Sankey < Base

    def data
     data_table = GoogleVisualr::DataTable.new
        data_table.new_column('string', 'From')
        data_table.new_column('string', 'To')
        data_table.new_column('number', 'Sum')

        data_table.add_rows(@data.to_a.map{|e| [e.to_a[0].last,e.to_a[1].last,e.to_a[2].last]})
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
