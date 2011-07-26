class HostsController < ApplicationController
  before_filter :verify_authenticity_token, :except => :create

  def index
    @hosts = Host.search_for(params[:search], :order => params[:order]).paginate(:page => params[:page])
    @counter = Host.count(:conditions => {:id => @hosts.map(&:id)}, :group => :host_id, :joins => :muxes)
  end

  def show
    @host = Host.find_by_name(params[:id])
    @muxes = Mux.where(:host_id => @host).includes([:package, :version, :arch]).order("packages.name ASC").paginate(:page => params[:page])
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
    Mux.delay.import(@host.name, params[:os], params[:packagelist]) if params[:script]
  end

  def edit
    @host = Host.find_by_name(params[:id])
  end

  def update
    @host = Host.find_by_name(params[:id])
    if @host.update_attributes(params[:host])
      flash[:notice] = "Successfully updated host."
      redirect_to @host
    else
      render :action => 'edit'
    end
  end

  def destroy
    @host = Host.find_by_name(params[:id])
    @host.destroy
    flash[:notice] = "Successfully destroyed host."
    redirect_to hosts_url
  end
end
