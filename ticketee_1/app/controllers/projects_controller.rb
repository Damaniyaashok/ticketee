class ProjectsController < ApplicationController
  def index
  end
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = "project Has been created"
      redirect_to @project
    else

    end
  end

  def show
    @project = Project.find(params[:id])
  end
private
  def project_params
    params.require(:project).permit(:name, :description)    
  end
end
