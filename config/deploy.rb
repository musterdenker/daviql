require 'bundler/capistrano'
load 'deploy/assets'

#set :default_shell, :bash
set :rvm_type, :system
set :rvm_ruby_string, "ruby-2.0.0-p247@daviql"
#set :rvm_autolibs_flag, :enable

require "rvm/capistrano"

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"

set :user, 'modomoto'
set :application, 'daviql'

set :deploy_to, "/home/#{user}/#{application}"
set :keep_releases, 3
set :rails_env, "production"

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid,  "#{deploy_to}/shared/pids/unicorn.pid"

set :scm, :none
set :repository, "."
set :deploy_via, :copy

set :scm_verbose, true
set :use_sudo, false

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :branch, ENV['BRANCH'] ? ENV['BRANCH'] : "master"

role :web, "modoruby.modotools.de" # Your HTTP server, Apache/etc
role :app, "modoruby.modotools.de" # This may be the same as your `Web` server
role :db, "modoruby.modotools.de", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do
    ;
  end
  task :stop do
    ;
  end
  task :restart, :roles => :app, :except => {:no_release => true} do
    #run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :serverstuff do
  desc "first time setup specific stuff"
  task :setup do
    # run "rvm use #{rvm_ruby_string} --create" 
    # run "gem install unicorn"
    # still not working - must be issued manually BEFORE first deploy
    puts ""
    puts "---- IMPORTANT ----"
    puts ""
    puts "  >> YOU MUST ISSUE 'rvm use #{rvm_ruby_string} --create' BEFORE first cap deploy! <<"
    puts "  >> YOU MUST ISSUE 'gem install unicorn' BEFORE first cap deploy! <<"
    puts ""
    puts "---- ---- ---- ----"
    puts ""
  end
  desc "link server specific scripts"
  task :symlink do
    run "sudo ln -s -f #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
  end
  desc "reload nginx"
  task :reload do
    #run "sudo service nginx reload"
  end

  before 'deploy:setup', 'serverstuff:setup'
  after 'deploy:create_symlink', 'serverstuff:symlink'
  after 'serverstuff:symlink', 'serverstuff:reload'  
end

namespace :unicorn do
  desc "start unicorn"
  task :start, :roles => :app, :except => {:no_release => true} do
    run "cd #{current_path} && bundle exec unicorn -c #{current_path}/config/unicorn.rb -E #{rails_env} -D"
  end
  desc "stop unicorn"
  task :stop, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -TERM `cat #{unicorn_pid}`"
  end
  desc "graceful stop unicorn"
  task :graceful_stop, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -QUIT `cat #{unicorn_pid}`"
  end
  desc "reload unicorn"
  task :reload, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -HUP `cat #{unicorn_pid}`"
  end

  after "deploy:restart", "unicorn:reload"
  after "deploy:start", "unicorn:start"
  after "deploy:stop", "unicorn:stop"
end

namespace :delayed_job do
  desc "Restart the delayed_job process"
  task :restart, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job restart"
  end

  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end

  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
  end

  task :status, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} ./script/delayed_job status"
  end

end

