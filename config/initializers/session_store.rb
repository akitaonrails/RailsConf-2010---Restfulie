# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_railsconf2010-apple_session',
  :secret      => 'a494a2ac834aa8754856b4647ce7cd076d36c27d1a9bd29b9c5031224cafe3ea57f3ee4118565f919898d32a98cd90b1bb0f8800654ff4f1da6811dee33afbaa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
