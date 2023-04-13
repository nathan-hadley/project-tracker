require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'should not save without name' do
    team = Team.new
    assert_not team.save, 'Saved team without a name'
  end
end

