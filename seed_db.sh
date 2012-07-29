rm log/*log
rm -r public/system/*
rake db:seed --trace
cd ../admin.okbrisbane
rake db:seed --trace
