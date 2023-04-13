# Endpoints to: Create/Update/Delete/Index/Show members
# Endpoint to: Update the team of a member
# Endpoint to: Add a member to a project
class MembersController < ApplicationController
  before_action :set_member, only: %i[update destroy show add_project projects]

  def create
    team = Team.find_by(id: params[:team_id])
    return render json: { error: 'Team not found' }, status: :unprocessable_entity if team.nil?

    @member = team.members.new(member_params)

    if @member.save
      render json: @member, status: :created
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def update
    if @member.update(member_params)
      render json: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    head :no_content
  end

  def index
    @members = Member.all
    render json: @members
  end

  def show
    render json: @member
  end

  def add_project
    project = Project.find(params[:project_id])
    @member.projects << project
    render json: @member.projects, status: :created
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.permit(:first_name, :last_name, :city, :state, :country, :team_id)
  end
end
