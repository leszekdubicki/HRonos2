require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HR2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    #custom configuration
    #add initial admin role in case it doesn't exist yet
    config.after_initialize do
        checkadmin = false
        if checkadmin
          puts "checking if base admin account exists... (remember to turn off if running rake after changing db setup)"
          @admin = Admin.where(email: "leszek.dubicki@student.ncirl.ie").first
          if not @admin
            puts "adding base admin account"
            Admin.create!({:email => "leszek.dubicki@student.ncirl.ie", :password => "admin123", :password_confirmation => "admin123" })
          end
        end
    end
  end
end
