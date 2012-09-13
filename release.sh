#!/bin/bash
rm -rf public/assets
rake assets:precompile --trace RAILS_ENV=production
DATE=`date +%Y%m%d`
tar jcvf ../release/okbrisbane_$DATE.tar.bz2\
 app/controllers\
 app/helpers\
 app/mailers\
 app/models\
 app/views\
 config/locales\
 config/routes.rb\
 config/application.rb\
 config/boot.rb\
 config/environment.rb\
 db\
 lib\
 public/*html\
 public/favicon.ico\
 public/assets\
 public/images\
 public/javascripts\
 public/robots.txt
rm -rf public/assets
