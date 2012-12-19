class HesController < ApplicationController
	before_filter :require_user
  before_filter :verify_admin
  
  def index
    @hes = He.find(:all, :order => "address ASC")
  end
  
  def new
    @new_he = He.new()
  end
  
  def create
    @new_he = He.new(params[:he])
    if @new_he.save
      flash[:notice] = "Pomyslnie dodano HE"
      redirect_to :action => "index"
    else
      flash[:error] = "Wystapil blad podczas dodawania HE"
      redirect_to :back
    end
  end
  
  def edit
    @he = He.find(params[:id])
  end
  
  def update
    @he = He.find(params[:id])
      if @he.update_attributes(params[:he])
        flash[:notice] = "Zaktualizowano HE"
        redirect_to :action => 'index'
      else
        flash[:notice] = "HE nie zostalo zaktualizowane"
        render :action => 'edit'
      end
  end
  
  def destroy
    if He.destroy(params[:id])
      flash[:notice] = "Pomyslnie usunieto HE"
    else
      flash[:error] = "Wystapil blad podczas usuwania HE"
    end
    redirect_to :action => "index"
  end
end
