# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dish_session',
  :secret      => 'df9d87435883a185a1c2e7a991d17abc11e6246df46cbe949db9bbbc188d245aa9e5fa42a19b1d5bbebe875961c7121823d670a3669f8bb2f0581366913c0b6e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
