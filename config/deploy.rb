require 'rvm/capistrano'
require 'bundler/capistrano'

ssh_options[:forward_agent] = true

set :server_name, "lynch.happybit.eu"
#set :shared_path, "~"
set :application, "happybit.eu"
# set :rvm_ruby_string, 'default'
# set :rvm_type, :user
#set :repository,  "~/#{application}.git"
# set :repository,  "git@bitbucket.org:aristotelis_ch/vblog.git"
set :repository, "git@github.com:aristotelisch/blog.git"
# Uses local instead of remote server keys, good for github ssh key deploy.
# ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :rvm_ruby_string, 'default'
set :rvm_type, :user
set :use_sudo, false
set :user, "deploy"
set :deploy_to, "/home/deploy/apps/#{application}"
set :rails_env, "production"
set :branch, "master"
set :keep_releases, 5
default_run_options[:pty] = true
ssh_options[:port] = 56
set :scm, :git
after "deploy:restart", "deploy:cleanup"

role :web, "lynch.happybit.eu"                          # Your HTTP server, Apache/etc
role :app, "lynch.happybit.eu"                          # This may be the same as your `Web` server
role :db,  "lynch.happybit.eu", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:setup", "db:configure"
after  "deploy:update_code", "db:symlink"
after  "deploy:symlink", "db:create"

namespace :db do
  desc "Create database yaml in shared path"
  task :configure do
    set :database_username do
      "rails"
    end

    set :database_password do
      Capistrano::CLI.password_prompt "Database Password: "
    end

    db_config = <<-EOF
          base: &base
            adapter: mysql2
            encoding: utf8
            reconnect: false
            pool: 5
            username: #{database_username}
            password: #{database_password}

          development:
            database: #{application}_development
            <<: *base

          test:
            database: #{application}_test
            <<: *base

          production:
            database: #{application}_production
            <<: *base
            EOF

            run "mkdir -p #{shared_path}/config"
            put db_config, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  desc "Create the database if it does not exist"
  task :create do
    run "cd #{current_path} && bundle exec rake db:create"
  end
end
