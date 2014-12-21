workers Integer(ENV['puma_workers'] || 3)
threads Integer(ENV['min_threads']  || 1), Integer(ENV['max_threads'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['port']     || 80
environment ENV['rack_env'] || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    config = ActiveRecord::Base.configurations[Rails.env] ||
                Rails.application.config.database_configuration[Rails.env]
    config['pool'] = ENV['max_threads'] || 16
    ActiveRecord::Base.establish_connection(config)
  end
end
