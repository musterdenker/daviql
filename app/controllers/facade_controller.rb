class FacadeController < ApplicationController


def start
	@queries = Query.all
end

end