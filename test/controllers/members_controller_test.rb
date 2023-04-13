require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:one)
    @member2 = members(:two)
    @team = teams(:one)
  end

  test 'should get list of members' do
    get members_url, as: :json
    assert_response :success

    json_response = JSON.parse(@response.body)

    member_names = json_response.map { |member| member["first_name"] }
    assert_includes member_names, @member.first_name
    assert_includes member_names, @member2.first_name
  end

  test 'should create member' do
    assert_difference('Member.count') do
      post members_url, params: { first_name: 'John', last_name: 'Doe', team_id: @team.id }, as: :json
    end

    assert_response 201

    json_response = JSON.parse(@response.body)
    assert_equal 'John', json_response['first_name']
  end

  test 'should not create member without first_name' do
    assert_no_difference('Member.count') do
      post members_url, params: { last_name: 'Doe', team_id: @team.id.to_s }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test 'should not create member without last_name' do
    assert_no_difference('Member.count') do
      post members_url, params: { first_name: 'John', team_id: @team.id.to_s }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test 'should not create member without team' do
    assert_no_difference('Member.count') do
      post members_url, params: { first_name: 'John', last_name: 'Doe' }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test 'should show member' do
    get member_url(@member), as: :json
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal @member.first_name, json_response['first_name']
  end

  test 'should update member' do
    patch member_url(@member), params: { first_name: 'Updated', last_name: 'Name', team_id: @team.id }, as: :json
    assert_response 200

    json_response = JSON.parse(@response.body)
    assert_equal 'Updated', json_response['first_name']

    @member.reload
    assert_equal 'Updated', @member.first_name
  end

  test 'should destroy member' do
    assert_difference('Member.count', -1) do
      delete member_url(@member), as: :json
    end

    assert_response 204

    assert_nil Member.find_by(id: @member.id)
  end
end
