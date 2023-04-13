# Endpoints to: Create/Update/Delete/Index/Show projects
# Endpoint to: Get the members of a specific project
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[update destroy show members]

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    head :no_content
  end

  def index
    @projects = Project.all
    render json: @projects
  end

  def show
    render json: @project
  end

  def members
    @members = @project.members
    render json: @members
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.permit(:name)
  end
end
