cd ../admin.okbrisbane
rake db:drop
rake db:create
rake db:migrate
rake db:test:load
rake db:seed
rm log/*log
rm -r public/system/*
cd ../okbrisbane
rake db:migrate
rake db:test:load
rake db:seed
