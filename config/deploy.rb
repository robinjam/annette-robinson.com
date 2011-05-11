# Capistrano multistage
require 'capistrano/ext/multistage'

# Bundler integration
require "bundler/capistrano"

# Application setup
set :application, "annette-robinson"
set :deploy_via, :remote_cache
set :user, "annette-robinson"
set :use_sudo, false

# SCM setup
set :scm, :git
set :repository, "file:///home/git/annette-robinson.git"
set :local_repository, "git@annette-robinson.com:annette-robinson.git"
set :scm_username, "annette-robinson"
set :git_enable_submodules, 1

# Passenger setup
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
