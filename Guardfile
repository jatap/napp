notification :growl

# Bundler
guard :bundler do
  watch('Gemfile')
  # watch(/^.+\.gemspec/)
end

# Rails
guard :rails,
  start_on_start: false do
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
end

# Yard (documentation)
guard :yard,
  stdout: 'log/yard.log' do

  watch(%r{app/.+\.rb})
  watch(%r{lib/.+\.rb})
  watch(%r{vendor/.+\.rb})
end

# RSpec
guard :rspec,
  cmd:              'bin/spring rspec -f html -o ./tmp/spec_results.html --fail-fast',
  launchy:          './tmp/spec_results.html',
  all_on_start:     false,
  failed_mode:      :focus,
  notification:     true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})          { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  watch('spec/rails_helper.rb')                       { "spec" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})     { |m| "spec/features/#{m[1]}_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end

