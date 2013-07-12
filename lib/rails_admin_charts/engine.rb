module RailsAdminCharts
  class Engine < ::Rails::Engine
    initializer 'RailsAdmin precompile hook', group: :all do |app|
      #app.config.assets.precompile += %w(application.js)
    end
  end
end
