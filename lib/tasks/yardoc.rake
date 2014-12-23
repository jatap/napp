require 'yard'

namespace :doc do

  YARD::Rake::YardocTask.new do |t|
    t.files   += ['app/**/*.rb', 'lib/**/*.rb']
    t.options += ['--protected']
    t.options += ['--private']
    t.options += ['--output-dir', 'doc/api']
    t.stats_options = ['--list-undoc']
  end

end
