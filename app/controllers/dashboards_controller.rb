class DashboardsController < ApplicationController

  def show
    @dashboard = Dashboard.find(params[:id])
    redirect_to root_url unless @dashboard.users.where("id = #{current_user.id}").count > 0
  end

  protected


end
