# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_city_of_darkness_session',
  :secret      => '78b23309e32d5c7b61b66308dfac56944f54bb9589bff680e25908b9051c59dd63439da1ce808a27747c0f3a74e5602fdb24d078708cc3e67f7e5dcef5d7c83c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
