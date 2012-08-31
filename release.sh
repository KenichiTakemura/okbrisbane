#!/bin/bash
DATE=`date +%Y%m%d`
tar jcvf okbrisbane_$DATE.tar.bz2\
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
 public/robots.txt
