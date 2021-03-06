require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module OBSWebUI
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
    config.assets.precompile += %w( cm2.js mobile.css mobile.js )

    # Skip frameworks you're not going to use
    #config.frameworks -= [ :action_web_service, :active_resource ]

    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{Rails.root}/extras )

    # Rails.root is not working directory when running under lighttpd, so it has
    # to be added to load path
    #config.load_paths << Rails.root unless config.load_paths.include? Rails.root
    
    # Force all environments to use the same logger level 
    # (by default production uses :info, the others :debug)
    # config.log_level = :debug
    
    config.log_tags = [:uuid]

    #config.cache_store = :dalli_store, 'localhost:11211', {:namespace => 'obs-webui', :compress => true }
    
    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector
    
    # Make Active Record use UTC-base instead of local time
    # config.active_record.default_timezone = :utc
    
    config.action_controller.perform_caching = true

    config.action_dispatch.rescue_responses.merge!('ActiveXML::Transport::UnauthorizedError' => 401)
    config.action_dispatch.rescue_responses.merge!('ActiveXML::Transport::ConnectionError' => 503)
    config.action_dispatch.rescue_responses.merge!('ActiveXML::Transport::Error' => 500)
    config.action_dispatch.rescue_responses.merge!('Timeout::Error' => 408)

    config.after_initialize do
      # See Rails::Configuration for more options
    end unless Rails.env.test?

  end
end
