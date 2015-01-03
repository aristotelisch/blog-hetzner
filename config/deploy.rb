require 'rvm/capistrano'
require 'bundler/capistrano'

ssh_options[:forward_agent] = true

set :nginx_path, "/opt/nginx/conf"
set :server_name, "slash.happybit.eu"#"lynch.happybit.eu"
set :database_host, "myoffload.prometeus.net"#"81.4.121.196"
set :database_port, 3306
#set :shared_path, "~"
set :application, "happybit_eu"
# set :rvm_ruby_string, 'default'
# set :rvm_type, :user
#set :repository,  "~/#{application}.git"
set :repository,  "git@github.com:aristotelisch/blog.git"
# Uses local instead of remote server keys, good for github ssh key deploy.
# ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :rvm_ruby_string, 'default'
set :rvm_type, :user
set :sudo, 'sudo'
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

role :web,  "slash.happybit.eu" #"lynch.happybit.eu"
role :app, "slash.happybit.eu"  #"lynch.happybit.eu"
role :db,  "slash.happybit.eu", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

before "deploy:setup", "db:configure"
after  "db:configure", "admin:upload_application.yml"
after  "deploy:update_code", "db:symlink"
before "deploy:assets:precompile", "db:symlink"
after  "db:symlink", "db:symlink_application_yml"
after  "db:symlink", "db:create"
after  "db:symlink", "db:elasticsearch_update"


namespace :db do
  desc "Update elasticsearch"
  task :elasticsearch_update do
    run "cd #{latest_release} && RAILS_ENV=production bundle exec rake environment elasticsearch:import:all"
  end

  desc "Create database yaml in shared path"
  task :configure, :roles => :app do
    set :database_username do
      #"rails"
      Capistrano::CLI.ui.ask "Database Username: "
    end

    set :database_password do
      Capistrano::CLI.password_prompt "Database Password: "
    end

    set :database_name do
      Capistrano::CLI.ui.ask "Database Name: "
    end

    db_config = <<-EOF
          base: &base
            adapter: mysql2
            encoding: utf8
            reconnect: false
            pool: 15
            username: #{database_username}
            password: #{database_password}
            host: #{database_host}
            port: #{database_port}

          production:
            database: #{database_name}
            <<: *base
            EOF

            run "mkdir -p #{shared_path}/config"
            put db_config, "#{shared_path}/config/database.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  # desc "Make symlink for application yaml"
  # task :symlink_application_yml, :roles => :app do
  #   run "ln -nfs #{shared_path}/config/application.yml #{latest_release}/config/application.yml"
  # end

  desc "Create the database if it does not exist"
  task :create, :roles => :app do
    run "cd #{latest_release} && bundle exec rake db:create RAILS_ENV=production"
  end

  desc "Migrate the database"
  task :migrate, :roles => :app do
    run "cd #{latest_release} && bundle exec rake db:migrate RAILS_ENV=production"
  end

  desc "Symlink application.yml"
  task :symlink_application_yml do
    run "ln -nfs #{shared_path}/config/application.yml #{latest_release}/config/application.yml"
  end

end

namespace :nginx do
  task :conf, :roles => :app do
    nginx_conf = <<-EOF
      # the nginx server instance
      server {
       listen       80;
       server_name  happybit.eu;
       root #{current_path}/public;
       passenger_enabled on;
      }
    EOF

    put nginx_conf, "/tmp/#{application}.conf"
    run "#{sudo} mv /tmp/#{application}.conf #{nginx_path}/sites-available"
    run "#{sudo} ln -s #{nginx_path}/sites-available/#{application}.conf #{nginx_path}/sites-enabled/#{application}.conf"
  end

  task :restart, :roles => :app do
    run "#{sudo} service nginx restart"
  end
end

namespace :admin do
  desc "Upgrade servers"
  task :upgrade do
    run "#{sudo} sudo apt-get update && sudo apt-get -y upgrade"
    run "rvm get stable"
  end

  desc "Check Uptime"
  task :uptime do
    run "uptime"
  end

  desc "Upload application.yml with enviroment variables"
  task :upload_application_yml do
    upload(File.expand_path('../application.yml', __FILE__), "#{shared_path}/config/application.yml")
    run "ln -nfs #{shared_path}/config/application.yml #{latest_release}/config/application.yml"
  end
end


