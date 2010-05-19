class HostsController < ApplicationController
  def index
    @search = Host.search params[:search]
    @hosts = @search.paginate(:page => params[:page])
    @counter = Host.count(:conditions => {:id => @hosts.map(&:id)}, :group => :host_id, :joins => :muxes)
  end

  def show
    @host = Host.find(params[:id])
    @packages = @host.packages.all.paginate :page => params[:page]
  end

  def new
    @host = Host.new
  end

  def create
    @host = Host.new(params[:host])
    if @host.save
      flash[:notice] = "Successfully created host."
      redirect_to @host
    else
      render :action => 'new'
    end
  end

  def edit
    @host = Host.find(params[:id])
  end

  def update
    @host = Host.find(params[:id])
    if @host.update_attributes(params[:host])
      flash[:notice] = "Successfully updated host."
      redirect_to @host
    else
      render :action => 'edit'
    end
  end

  def destroy
    @host = Host.find(params[:id])
    @host.destroy
    flash[:notice] = "Successfully destroyed host."
    redirect_to hosts_url
  end
end
