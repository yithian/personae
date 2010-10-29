require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "should remind username" do
    email = UserMailer.forgot_username(users(:one)).deliver
    
    assert(!ActionMailer::Base.deliveries.empty?, "message didn't get queued")
    assert_equal([users(:one).email_address], email.to)
    assert_equal("Forgotten username", email.subject)
  end
  
  test "should send reset password link" do
    users(:one).generate_reset_code
    email = UserMailer.forgot_password(users(:one), "http://some.hostname.tld/admin/reset_password?reset_code=#{users(:one).reset_code}").deliver
    
    assert(!ActionMailer::Base.deliveries.empty?, "message didn't get queued")
    assert_equal([users(:one).email_address], email.to)
    assert_equal("Reset password", email.subject)
  end
end
