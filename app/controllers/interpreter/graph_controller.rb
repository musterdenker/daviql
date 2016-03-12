class Interpreter::GraphController < Interpreter::BaseController

  def show
    @query = get_query
    @data = @query.execute
    @layout = get_layout
    respond_to do |format|
      format.html {
        @bar_chart = Presenters::Chart::Bar.new(@query, @data, @layout)
        render "interpreter/show"
      }
      format.csv {
        csv = CSV.generate do |csv|
          csv << @data.first.to_a.map(&:first)
          @data.each do |e|
            csv << e.values
          end
        end
        send_data csv
      }
      format.js{
        @bar_chart = Presenters::Chart::Bar.new(@query, @data, @layout)
        render  "interpreter/show"
      }
    end

  end

end
