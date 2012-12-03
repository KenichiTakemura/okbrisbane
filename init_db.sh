cd ../admin.okbrisbane
rake db:drop --trace RAILS_ENV="production"
rake db:drop --trace
rake db:create --trace RAILS_ENV="production"
rake db:create
rake db:reset --trace RAILS_ENV="production"
rake db:migrate --trace RAILS_ENV="production"
rake db:reset --trace
rake db:migrate --trace
rake db:test:load
cd ../okbrisbane
rake db:migrate --trace RAILS_ENV="production"
rake db:migrate --trace RAILS_ENV="development"
rake db:test:load
rm -rf public/system/data
