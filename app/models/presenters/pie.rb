module Presenters
  class Pie < Base

    def data

      data_table = GoogleVisualr::DataTable.new
      get_columns.each do |column|
        column_type = 'string'
        case column
          when 'count'
            column_type = 'number'
        end
        data_table.new_column(column_type, column)
      end

      data_table.add_rows(get_data_rows)


      option = {
          title: @query.name,
          legend: {position: 'right', textStyle: {:fontSize => 16}},
          height: 600,
          material: false,
          width: @layout[:width],
          height: @layout[:height]
      }
      GoogleVisualr::Interactive::PieChart.new(data_table, option)
    end

    def debug
      @data.values.inspect
    end

    def get_columns
      @data.fields
    end

    def get_data_rows
      case @query.data_source.database_type
        when 'postgresql'
          values = []
          @data.values.each do |v|
            values << [v[0], v[1].to_i]
          end
          values
        when 'mysql'
          @data
      end
    end

  end
end