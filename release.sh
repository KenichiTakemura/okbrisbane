#!/bin/bash
DATE=`date +%Y%m%d%H%M`
tar jcvf ../release/okbrisbane_$DATE.tar.bz2\
 app/controllers\
 app/helpers\
 app/mailers\
 app/models\
 app/views\
 script\
 config/locales\
 config/routes.rb\
 config/application.rb\
 config/boot.rb\
 config/environment.rb\
 config/initializers/okbrisbane.rb\
 db\
 lib\
 public/*html\
 public/favicon.ico\
 public/assets/manifest.yml\
 public/assets/application*\
 public/images\
 public/javascripts\
 public/robots.txt
#mv tmp/release/manifest.yml tmp/release/manifest.yml.$DATE
#cp -p public/assets/manifest.yml tmp/release
mv public/assets public/x_assets
cd ../okbrisbane-stage
./unpack.sh ../release/okbrisbane_$DATE.tar.bz2
cd -
