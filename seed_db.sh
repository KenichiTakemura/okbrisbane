rm log/*log
rm -r public/system/*
rake db:seed
cd ../admin.okbrisbane
rake db:seed
