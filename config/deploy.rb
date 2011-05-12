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

# Paperclip
namespace :paperclip do
  task :refresh, :roles => :app do
    run "cd #{current_path} && bundle exec rake paperclip:refresh CLASS=Image RAILS_ENV=production"
  end
end

# Upload folder symlink
namespace :customs do
  task :symlink, :roles => :app do
    run "ln -nfs #{shared_path}/uploads/images #{release_path}/uploads/images"
  end
  task :setup, :roles => :app do
    run "mkdir -p #{shared_path}/uploads/images"
  end
end

before "deploy:symlink", "customs:symlink"
after "deploy:setup", "customs:setup"
