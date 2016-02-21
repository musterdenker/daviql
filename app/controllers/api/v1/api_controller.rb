module Api::V1
  class ApiController < ApplicationController
    skip_before_action :authenticate_user!


    def render_unauthorized
      render plain: 'Wrong auth token', status: :unauthorized
    end

    def render_not_found
      render plain: 'Query not found', status: :not_found
    end

  end
end