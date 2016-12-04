class Interpreter::CsvController < Interpreter::BaseController
  def show
    @query = get_query
    @query.add_usage current_user
    @data = @query.get_data

    respond_to do |format|
      format.csv {
        send_csv @data
      }
    end
  end
end
