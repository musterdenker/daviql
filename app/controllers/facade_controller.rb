class FacadeController < ApplicationController
	before_filter :authenticate_user!

def start
	@queries = Query.all
end

end