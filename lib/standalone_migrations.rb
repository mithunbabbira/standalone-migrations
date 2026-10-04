lib_path = File.expand_path("../", __FILE__)
$:.unshift lib_path unless $:.include?(lib_path)

require "rubygems"
require "logger"

# Rails and ActiveRecord are optional dependencies.
# The gem can work in non-Rails projects that only need ActiveRecord.
begin
  require "rails"
rescue LoadError
  # Rails is not installed; that is OK for non-Rails usage
end

begin
  require "active_record"
rescue LoadError
  # ActiveRecord is not installed; tasks will not be available
  # Users should add activerecord and railties to their Gemfile
end

if defined?(Rails)
  require "standalone_migrations/configurator"
  require "standalone_migrations/generator"
  require "standalone_migrations/callbacks"

  railtie_app_path = "#{lib_path}/standalone_migrations/minimal_railtie_config"
  APP_PATH = File.expand_path(railtie_app_path,  __FILE__)

  require "standalone_migrations/minimal_railtie_config"
  require "standalone_migrations/tasks"

  if !ENV["RAILS_ENV"]
    ENV["RAILS_ENV"] = ENV["DB"] || ENV["RACK_ENV"] || Rails.env || "development"
  end
end
