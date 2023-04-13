require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
    @project2 = projects(:two)
  end

  test 'should list projects' do
    get projects_url, as: :json
    assert_response :success

    json_response = JSON.parse(@response.body)

    project_names = json_response.map { |project| project["name"] }
    assert_includes project_names, @project.name
    assert_includes project_names, @project2.name
  end

  test 'should create project' do
    assert_difference('Project.count') do
      post projects_url, params: { name: 'New Project' }, as: :json
    end

    assert_response 201

    json_response = JSON.parse(@response.body)
    assert_equal 'New Project', json_response['name']
  end

  test 'should not create project without a name' do
    assert_no_difference('Project.count') do
      post projects_url, as: :json
    end

    assert_response :unprocessable_entity
  end

  test 'should show project' do
    get project_url(@project), as: :json
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal @project.name, json_response['name']
  end

  test 'should update project' do
    patch project_url(@project), params: { name: 'Updated Project' }, as: :json
    assert_response 200

    json_response = JSON.parse(@response.body)
    assert_equal 'Updated Project', json_response['name']

    @project.reload
    assert_equal 'Updated Project', @project.name
  end

  test 'should destroy project' do
    assert_difference('Project.count', -1) do
      delete project_url(@project), as: :json
    end

    assert_response 204

    assert_nil Project.find_by(id: @project.id)
  end
end

