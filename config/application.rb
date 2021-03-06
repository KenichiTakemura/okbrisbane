require File.expand_path('../boot', __FILE__)
require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
# If you want your assets lazily compiled in production, use this line
# Bundler.require(:default, :assets, Rails.env)
end

module Okbrisbane
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    config.autoload_paths += %W(#{Rails.root}/lib)
    config.autoload_paths += %W(#{Rails.root}/app/controllers/attachable)
    config.autoload_paths += %W(#{Rails.root}/app/controllers/users)
    config.autoload_paths += %W(#{Rails.root}/app/models/ckeditor)
    config.autoload_paths += %W(#{Rails.root}/app/models/singleton)
    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ko

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true

    #config.assets.paths << "#{Rails.root}/app/assets/stylesheets/fonts"
    #config.assets.paths << "#{Rails.root}/vendor/assets/stylesheets/images"
    #config.assets.paths << "#{Rails.root}/app/assets/stylesheets/messages"
    #config.assets.paths << "#{Rails.root}/vendor/assets/javascripts/ckeditor"
    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    
    # http://stackoverflow.com/questions/5267998/rails-3-field-with-errors-wrapper-changes-the-page-appearance-how-to-avoid-t
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      "#{html_tag}".html_safe 
    }
    
    config.assets.precompile += ['bootstrap.css','bootstrap.js','jquery.mobile-1.2.0.min.js','jquery.mobile.structure-1.2.0.min.css','jquery.mobile.theme-1.2.0.min.css']
    
  end
end
