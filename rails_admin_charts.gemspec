$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'rails_admin_charts/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails_admin_charts'
  s.version     = RailsAdminCharts::VERSION
  s.authors     = ['Paul Geraghty']
  s.email       = %w(pgeraghty07@gmail.com)
  s.homepage    = 'https://github.com/pgeraghty/rails_admin_charts'
  s.summary     = 'Charts for Rails Admin'
  s.description = 'Per-Model HighCharts for Rails Admin'

  s.files = Dir['{app,config,db,lib}/**/*'] + %w(MIT-LICENSE Rakefile README.md)

  s.add_dependency 'rails', '>= 3.2'
  s.add_dependency 'rails_admin', '> 0'
  s.add_dependency 'lazy_high_charts', '>= 1.4.3'
end
