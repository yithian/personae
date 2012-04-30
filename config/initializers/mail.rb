ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.gmail.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'infinitepersonae@gmail.com',
  :password       => ENV['OPENSHIFT_DB_PASSWORD'],
  :domain         => 'gmail.com'
}
ActionMailer::Base.delivery_method = :smtp