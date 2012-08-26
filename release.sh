#!/bin/bash
DATE=`date +%Y%m%d`
tar jcvf okbrisbane_$DATE.tar.bz2 app config* db Gemfile* init_db.sh lib Rakefile script vendor public/*.html public/favicon.ico public/robots.txt
