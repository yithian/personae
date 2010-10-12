require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "should remind username" do
    email = UserMailer.forgot_username(users(:one)).deliver
    
    assert(!ActionMailer::Base.deliveries.empty?, "message didn't get queued")
    assert_equal([users(:one).email_address], email.to)
    assert_equal("Forgotten username", email.subject)
  end
end
