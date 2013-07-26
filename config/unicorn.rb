root = "/home/deployer/apps/dss-messenger/current"
working_directory root
pid "#{root}/tmp/pids/unicorn_messenger.pid"
stderr_path "#{root}/log/unicorn_messenger.log"
stdout_path "#{root}/log/unicorn_messenger.log"

listen "/tmp/unicorn.dss-messenger.sock"
worker_processes 2
timeout 30
