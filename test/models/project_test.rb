require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'should not save without name' do
    project = Project.new
    assert_not project.save, 'Saved project without a name'
  end
end

