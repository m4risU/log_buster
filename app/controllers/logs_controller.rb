class LogsController < ApplicationController
  def index
    @logs = Log.order("created_at desc").page(params[:page]).per_page(30)
  end
end
