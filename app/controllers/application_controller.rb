class ApplicationController < ActionController::Base
  protect_from_forgery

  def auto_complete_search
    begin
      @items = eval(controller_name.singularize.camelize).complete_for(params[:search])
    rescue ScopedSearch::QueryNotSupported => e
      @items = [{:error =>e.to_s}]
    end
    render :json => @items
  end

end
