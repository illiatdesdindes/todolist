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
      respond_with @list, :location => list_path(@list)
      # or just html redirect_to list_path(@list)
    else
      #une seule ligne au lieu de deux: le flash est le deuxieme argument
      # seul sont disponible :
      #   - :alert
      #   - :notice
      # pour le reste faut passer par le hash
      # ou une forme plus longue
      # redirect_to new_list_path, :flash => { :error => "Could not create list"}
      redirect_to new_list_path, :alert => "Could not create list"
    end
  end
  
  def show
    @list = List.find(params[:id])
    @task = @list.tasks.new
    
    respond_with ( @list )
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      flash[:success] = "List updated."
      respond_with @list, :location => list_path(@list)
    else
      redirect_to edit_list_path, :flash => { :error => "Could not edit list" }
    end
  end
  
  def destroy
    @list = List.find(params[:id])
    if @list.destroy
      flash[:success] = "List deleted"
      redirect_to lists_path
    else
      redirect_to lists_path, :error => "Could not delete list. Have you done everything ?"
    end
  end 
end
