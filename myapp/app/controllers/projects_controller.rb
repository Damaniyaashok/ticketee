class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @project = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Project have been created."
      redirect_to @project
    else
      flash[:alert] = "Project has not been created."
      render "new"
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project has been destroyed."
    redirect_to projects_path
  end

    private

      def project_params
        params.require(:project).permit(:name, :description)
      end

      def set_project
        @project = Project.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The Project you are looking for not found"
        redirect_to project_path
      end

      def authorize_admin!
        require_signin!
        unless current_user.admin?
          flash[:alert] = "You must be an admin to do that."
          redirect_to root_path
        end
      end
end
