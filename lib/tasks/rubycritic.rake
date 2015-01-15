require 'colorize'

namespace :rubycritic do

  desc 'RubyCritic code metrics'
  task check: :environment do
    puts '- Run rubycritics checking process.'.green
    sh('rubycritic app')
    puts '- Process has finished.'.green
  end
end
