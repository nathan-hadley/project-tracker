require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = teams(:one)
    @team2 = teams(:two)
  end

  test 'should get list of teams' do
    get teams_url, as: :json
    assert_response :success

    json_response = JSON.parse(@response.body)

    team_names = json_response.map { |team| team["name"] }
    assert_includes team_names, @team.name
    assert_includes team_names, @team2.name
  end

  test 'should create team' do
    assert_difference('Team.count') do
      post teams_url, params: { name: 'New Team' }, as: :json
    end

    assert_response 201
  end

  test 'should show team' do
    get team_url(@team), as: :json
    assert_response :success
  end

  test 'should update team' do
    patch team_url(@team), params: { name: 'Updated Team' }, as: :json
    assert_response 200
  end

  test 'should destroy team' do
    assert_difference('Team.count', -1) do
      delete team_url(@team), params: { new_team_id: @team2.id.to_s }, as: :json
    end

    assert_response 204
  end
end

