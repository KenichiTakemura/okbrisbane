# Be sure to restart your server when you modify this file.
if Okbrisbane::Application.config.ok_debug
  Okbrisbane::Application.config.session_store :cookie_store, :key => '_okbrisbane_session', :domain => "www.okbrisbane-devel.com"
else
  Okbrisbane::Application.config.session_store :cookie_store, :key => '_okbrisbane_session', :domain => "www.okbrisbane.com"
end  
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Okbrisbane::Application.config.session_store :active_record_store
