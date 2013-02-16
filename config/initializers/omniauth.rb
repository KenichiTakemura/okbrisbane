Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "141763349073.apps.googleusercontent.com", "b8Ogm0WpLzBId8fTViXuxlhM", :strategy_class => OmniAuth::Strategies::Google, :scope => 'https://www.googleapis.com/auth/docs https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
  #provider :naver, "_BMNzVP2b9Hd", "510078FAFqe7_mdDB4cG", :strategy_class => OmniAuth::Strategies::Naver
end

OmniAuth.config.on_failure do |env|
  [200, {}, [env['omniauth.error'].inspect]]
end
