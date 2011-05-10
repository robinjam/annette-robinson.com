# Bundler integration
require "bundler/capistrano"

# Application setup
set :application, "annette-robinson"
server "staging.annette-robinson.com", :app, :web, :db, :primary => true
set :deploy_to, "/home/annette-robinson/annette-robinson"
set :deploy_via, :remote_cache
set :user, "annette-robinson"
set :use_sudo, false

# SCM setup
set :scm, :git
set :repository, "file:///home/git/annette-robinson.git"
set :local_respository, "git@staging.annette-robinson.com:annette-robinson.git"
set :scm_username, "annette-robinson"
set :branch, "dev"

# Passenger setup
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
