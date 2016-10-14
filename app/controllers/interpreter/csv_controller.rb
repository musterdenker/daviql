class Interpreter::CsvController < Interpreter::BaseController
  def show
    @query = get_query

    @data = @query.get_data

    respond_to do |format|
      format.csv {
        send_csv @data
      }
    end
  end
end
