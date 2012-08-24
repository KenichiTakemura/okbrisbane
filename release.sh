#!/bin/bash
DATE=`date +%Y%m%d`
tar jcvf admin.okbrisbane_$DATE.tar.bz2 app config* db Gemfile* *.sh lib Rakefile script vendor public/*.html public/favicon.ico public/images public/javascripts public/robots.txt
