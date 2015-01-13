require 'colorize'

namespace :scripts do

  desc 'Base application dependencies to handle by generators'
  task dependencies: :environment do
    puts '- Search base application dependencies (handle by generators).'.green
    sh('grep -Ri napp * | grep -v "log\|tmp\|doc\|coverage"')
    puts '- Search has finished.'.green
  end
end
