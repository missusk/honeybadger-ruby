begin
  # Require these early to work around https://github.com/jruby/jruby#6547
  #   can be pulled out > 9.2.14 of jruby.
  require "i18n"
  require "i18n/backend/simple"
  require "rails"
  RAILS_PRESENT = true

  # We are unable to run Activerecord with rails edge on jruby as the sqlite
  # adapter is not supported, so we are skipping activrecord specs just for
  # that runtime and Rails version
  SKIP_ACTIVE_RECORD = !!(defined?(JRUBY_VERSION) && (Rails::VERSION::PRE == "alpha" || Rails::VERSION::MAJOR >= 8))

  require FIXTURES_PATH.join("rails", "config", "application.rb")
  require "honeybadger/init/rails"
  require "rspec/rails"
rescue LoadError
  RAILS_PRESENT = false
  SKIP_ACTIVE_RECORD = true
  puts "Skipping Rails integration specs."
end

# Defining this as a method as we only want to include these hooks in rails
# integration specs. Since these specs run inline with non-rails specs, we
# don't want to attach these hooks to the global config
def load_rails_hooks(spec)
  spec.before(:all) do
    Honeybadger.configure do |config|
      config.api_key = "gem testing"
      config.backend = "test"
      config.events.batch_size = 0
    end

    # Because we create a new Agent after each spec run, initialize it with
    # the same framework config as the Railtie. Re-running every Rails load
    # hook is unsafe because framework hooks are not necessarily idempotent.
    if RailsApp.initialized?
      Honeybadger.init!({
        root: Rails.root.to_s,
        env: Rails.env,
        "config.path": Rails.root.join("config", "honeybadger.yml"),
        logger: Honeybadger::Logging::FormattedLogger.new(Rails.logger),
        framework: :rails
      })
      Honeybadger.load_plugins!
    else
      RailsApp.initialize!
    end
  end

  spec.after(:each) do
    Honeybadger::Backend::Test.notifications[:notices].clear
    Honeybadger::Backend::Test.events.clear
  end
end
