root = "/home/deployer/apps/dss-messenger/current"
working_directory root
pid "#{root}/tmp/pids/unicorn_messenger.pid"
stderr_path "#{root}/log/unicorn_messenger.log"
stdout_path "#{root}/log/unicorn_messenger.log"

listen "/tmp/unicorn.dss-messenger.sock"
worker_processes 2
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end 

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
