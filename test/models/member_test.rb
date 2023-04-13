require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test 'should not save without first_name and last_name' do
    member = Member.new
    assert_not member.save, 'Saved member without first_name and last_name'
  end
end
