require 'sinatra/base'
require 'staticmatic'

module Sinatra
  module DynamicMatic
    def self.registered(app)
      app.set :compile_on_start, true

      app.set :lock, true
      app.set :public, Proc.new {app.root && File.join(app.root, 'site')}

      configuration = StaticMatic::Configuration.new

      config_file = "#{app.root}/src/configuration.rb"

      if File.exists?(config_file)
        config = File.read(config_file)
        eval(config)
      end

      staticmatic = StaticMatic::Base.new(app.root, configuration)
      staticmatic.run("build") if app.compile_on_start

      Dir[File.join(staticmatic.src_dir, "layouts", "*.haml")].each do |layout|
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
  end

  register DynamicMatic
end
