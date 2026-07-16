# minimal rails gems required to run rails
# https://github.com/rails/rails/blob/main/rails.gemspec
RAILS_GEMS = %w[activesupport activemodel activerecord activejob railties actionpack]

appraise "standalone" do
end

if !RUBY_PLATFORM.match?(/java/)
  appraise "binding_of_caller" do
    gem "binding_of_caller"
  end
end

appraise "rack-1" do
  # Old (pre-2.0) Rack, works on all Rubies.
  gem "rack", "< 2.0"
end

appraise "delayed_job" do
  gem "delayed_job", "< 4.1.2" # See https://github.com/collectiveidea/delayed_job/pull/931
  gem "activesupport", "> 3.1.12", "< 5.0.0" # Prevent buggy version from being installed
end

appraise "resque" do
  gem "resque"
  gem "mock_redis"
end

appraise "sidekiq" do
  gem "sidekiq", "~> 6"
end

appraise "sidekiq7" do
  gem "sidekiq", "~> 7"
end

if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.5.0")
  appraise "rails6.1" do
    RAILS_GEMS.each { |rails_gem| gem rails_gem, "~> 6.1" }
    gem "sqlite3", "~> 1.4", platforms: :mri
    gem "activerecord-jdbcsqlite3-adapter", platforms: :jruby
    gem "psych", "< 5.2.4", platforms: :jruby
    gem "better_errors", require: false, platforms: :mri
    gem "rack-mini-profiler", require: false
    gem "rspec-rails"
    gem "listen"
    gem "tzinfo-data" # Needed for timezones to work on Windows
  end

  appraise "rails7.0" do
    RAILS_GEMS.each { |rails_gem| gem rails_gem, "< 7.1" }
    gem "sqlite3", "~> 1.4", platforms: :mri
    gem "activerecord-jdbcsqlite3-adapter", platforms: :jruby
    gem "psych", "< 5.2.4", platforms: :jruby
    gem "better_errors", require: false, platforms: :mri
    gem "rack-mini-profiler", require: false
    gem "rspec-rails"
    gem "tzinfo-data" # Needed for timezones to work on Windows
  end

  appraise "rails7.1" do
    RAILS_GEMS.each { |rails_gem| gem rails_gem, "< 7.2" }
    gem "sqlite3", "~> 1.4", platforms: :mri
    gem "activerecord-jdbcsqlite3-adapter", platforms: :jruby
    gem "psych", "< 5.2.4", platforms: :jruby
    gem "better_errors", require: false, platforms: :mri
    gem "rack-mini-profiler", require: false
    gem "rspec-rails"
    gem "tzinfo-data" # Needed for timezones to work on Windows
  end

  appraise "rails7.2" do
    RAILS_GEMS.each { |rails_gem| gem rails_gem, "< 7.3" }
    gem "sqlite3", "~> 2", platforms: :mri
    gem "activerecord-jdbcsqlite3-adapter", platforms: :jruby
    gem "psych", "< 5.2.4", platforms: :jruby
    gem "better_errors", require: false, platforms: :mri
    gem "rack-mini-profiler", require: false
    gem "rspec-rails"
    gem "tzinfo-data" # Needed for timezones to work on Windows
  end

  appraise "rails8" do
    RAILS_GEMS.each { |rails_gem| gem rails_gem, "~> 8.0.2" }
    gem "sqlite3", "~> 2", platforms: :mri
    gem "better_errors", require: false, platforms: :mri
    gem "rack-mini-profiler", require: false
    gem "rspec-rails"
    gem "tzinfo-data" # Needed for timezones to work on Windows

    # bigdecimal (from the root Gemfile) is a C extension; keep it off JRuby.
    # It is re-added below for MRI only.
    remove_gem "bigdecimal"

    platforms :jruby do
      gem "activerecord-jdbcsqlite3-adapter"

      # Let Bundler pick the JRuby build of psych (>= 5.2.4 on java doesn't pull the C-ext `date` gem)
      gem "psych", "~> 5.2", require: false

      # Keep IRB usable without dragging in `io-console` (MRI-only C ext)
      gem "reline", "~> 0.5.10", require: false

      gem "nokogiri"
      gem "racc", ">= 1.7.3"

      # Ensure MRI-only bits never try to build on JRuby
      gem "io-console", platforms: [:ruby]
      gem "date", platforms: [:ruby]
      gem "bigdecimal", platforms: [:ruby]
    end
  end

  # Rails edge
  appraise "rails" do
    gem "activesupport", "> 7", github: "rails", branch: "main"
    (RAILS_GEMS - %w[activesupport]).each { |rails_gem| gem rails_gem, github: "rails", branch: "main" }
    gem "rack", github: "rack/rack"
    gem "arel", github: "rails/arel"
    gem "sqlite3", "~> 2", platforms: :mri
    gem "capistrano", "~> 3.0"
    gem "better_errors", require: false, platforms: :mri
    gem "rspec-rails"

    # Listen is a soft-dependency in Rails 5. Guard requires listen (which makes
    # it present when generating a new Rails app), so Rails expects it to be
    # there. See https://github.com/rails/rails/pull/24066
    gem "listen"
    gem "tzinfo-data" # Needed for timezones to work on Windows

    # bigdecimal (from the root Gemfile) is a C extension; keep it off JRuby.
    # It is re-added below for MRI only.
    remove_gem "bigdecimal"

    platforms :jruby do
      gem "activerecord-jdbcsqlite3-adapter"

      # Let Bundler pick the JRuby build of psych (>= 5.2.4 on java doesn't pull the C-ext `date` gem)
      gem "psych", "~> 5.2", require: false

      # Keep IRB usable without dragging in `io-console` (MRI-only C ext)
      gem "reline", "~> 0.5.10", require: false

      gem "nokogiri"
      gem "racc", ">= 1.7.3"

      # Ensure MRI-only bits never try to build on JRuby
      gem "io-console", platforms: [:ruby]
      gem "date", platforms: [:ruby]
      gem "bigdecimal", platforms: [:ruby]
    end
  end
end

appraise "rack" do
  gem "rack", ">= 2.0.0"
end

appraise "sinatra" do
  gem "sinatra"
  gem "rack-test"
end

appraise "hanami" do
  gem "hanami", "~> 2.0"
  gem "hanami-router", "~> 2.0"
  gem "rack-test"
end
