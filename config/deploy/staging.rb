server "staging.annette-robinson.com", :app, :web, :db, :primary => true
set :deploy_to, "/srv/www/annette-robinson/staging"
set :branch, "dev"
