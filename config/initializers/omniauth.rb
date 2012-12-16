#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :facebook, "399702043433879", "5087792788ce85f7b868dbe53691c53e", :strategy_class => OmniAuth::Strategies::Facebook, :display => 'popup', :scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access, publish_stream'
#end

OmniAuth.config.on_failure do |env|
  [200, {}, [env['omniauth.error'].inspect]]
end
