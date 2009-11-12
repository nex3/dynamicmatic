module Sinatra
  module DynamicMatic
    class Middleware
      def initialize(app)
        @app = app
        @server = StaticMatic::Server.new(app.send(:staticmatic), @app)
      end

      def call(env)
        @server.call(env)
      end
    end
  end
end
