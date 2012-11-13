mkdir -p tmp/bootstrap
cd tmp/bootstrap
mv ~/Downloads/bootstrap.zip .
unzip bootstrap.zip
cp -p js/bootstrap.min.js ../../vendor/assets/javascripts/bootstrap.js
cp -p css/bootstrap.min.css ../../vendor/assets/stylesheets/bootstrap.css
cd ../..
rm -rf tmp/bootstrap
