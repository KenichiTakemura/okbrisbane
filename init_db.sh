cd ../admin.okbrisbane
rake db:drop
rake db:create
rake db:migrate
rake db:test:load
cd ../okbrisbane
rake db:migrate
rake db:test:load
./seed_db.sh
