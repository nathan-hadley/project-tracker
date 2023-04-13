# Endpoints to: Create/Update/Delete/Index/Show teams
# Endpoint to: Get the members of a specific team
class TeamsController < ApplicationController
  before_action :set_team, only: %i[update destroy show members]

  def create
    @team = Team.new(team_params)

    if @team.save
      render json: @team, status: :created
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    head :no_content
  end

  def index
    @teams = Team.all
    render json: @teams
  end

  def show
    render json: @team
  end

  def members
    @members = @team.members
    render json: @members
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
