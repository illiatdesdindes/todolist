class ListsController < ApplicationController
  
  respond_to :html, :xml, :js
  
  def index
    respond_with( @lists = List.all)
  end
  
  def new
    @list = List.new
  end
  
  def create
    @list = List.new(params[:list])
    
    if @list.save
      flash[:success] = "List created."
      redirect_to list_path(@list)
    else
      #une seule ligne au lieu de deux: le flash est le deuxieme argument 
      redirect_to new_list_path, :error => "Could not create list"
    end
  end
  
  def show
    @list = List.find(params[:id])
  end
end
