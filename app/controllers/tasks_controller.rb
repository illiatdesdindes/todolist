class TasksController < ApplicationController
  
  #attr_accessor :completed
  before_filter :find_list
  respond_to :html, :xml, :js

  def create 
    #@list = List.find(params[:list_id])
    @task = @list.tasks.new(params[:task])
    
    # ou
    # @task = Task.new(:list_id => params[:list_id])
    
    if @task.save
      redirect_to list_path(@list), :flash => { :success => "Task created" }
    else
      redirect_to list_path(@list), :flash => { :error => "Could not creat task at this time" }
    end
  end
  
  def complete 
    #@list = List.find(params[:list_id])
    @task = Task.find(params[:id])
    # ou @task = @list.tasks.find(params[:id])
    
    @task.completed = true
    @task.save
    redirect_to list_url(@list)
  end
  
  private
  
  def find_list
    @list = List.find(params[:list_id])
  end
  
end
