require 'sinatra/base'
require 'staticmatic'
require File.dirname(__FILE__) + '/dynamicmatic/middleware'

module Sinatra
  module DynamicMatic
    def self.registered(app)
      app.set :lock, true
      app.set :public, Proc.new {app.root && File.join(app.root, 'site')}

      # If we're in development, don't serve the StaticMatic files statically.
      # Instead, render them dynamically, as with `staticmatic preview`.
      app.use Middleware if app.environment == :development

      configuration = StaticMatic::Configuration.new

      config_file = "#{app.root}/src/configuration.rb"

      if File.exists?(config_file)
        config = File.read(config_file)
        eval(config)
      end

      staticmatic = StaticMatic::Base.new(app.root, configuration)
      app.set :_staticmatic, staticmatic

      Dir[File.join(app._staticmatic.src_dir, "layouts", "*.haml")].each do |layout|
        name = layout[/([^\/]*)\.haml$/, 1].to_sym
        haml = File.read(layout)
        app.template(name) {haml}
        app.layout {haml} if name == :application
      end

      before do
        @staticmatic = staticmatic
        staticmatic.instance_variable_set('@current_page', request.path_info)
      end
    end

    def staticmatic
      _staticmatic
    end
  end

  register DynamicMatic
end
