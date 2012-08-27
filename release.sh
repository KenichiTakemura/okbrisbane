#!/bin/bash
DATE=`date +%Y%m%d`
tar jcvf okbrisbane_$DATE.tar.bz2 app config/locales config/routes.rb db Gemfile lib init_db.sh seed_db.sh
