if Rails.env == "development"
  require_dependency "#{Rails.root}/app/models/browser_log.rb"
end

