Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true
  config.react.variant = :production
  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true


  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = true 

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  config.log_level = :info

  # Use a different cache store in production.
  if ENV["MEMCACHEDCLOUD_SERVERS"]
    config.cache_store = :dalli_store, ENV["MEMCACHEDCLOUD_SERVERS"].split(','), {
      :username => ENV["MEMCACHEDCLOUD_USERNAME"], :password => ENV["MEMCACHEDCLOUD_PASSWORD"], :compress => true, :expires_in => 1.day
    }
  end

  # config.action_controller.asset_host = "http://assets.example.com"
  config.assets.initialize_on_precompile = false
  config.assets.paths << Rails.root.join("app", "assets", "fonts").to_s
  config.assets.precompile << (/\.(?:svg|eot|woff|ttf|png)$/)

  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
