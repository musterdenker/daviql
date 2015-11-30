working_directory "/home/modomoto/daviql/current"
pid               "/home/modomoto/daviql/current/tmp/pids/unicorn.pid"
stderr_path       "/home/modomoto/daviql/current/log/unicorn.err.log"
stdout_path       "/home/modomoto/daviql/current/log/unicorn.out.log"
 
listen "/tmp/unicorn.daviql.socket", :backlog => 64
#listen 8080, :tcp_nopush => true

worker_processes 5

timeout 480

preload_app false

GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
