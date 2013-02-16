#rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile
rm -rf public/x_assets
mv public/assets public/x_assets
bundle exec rake assets:precompile --trace RAILS_ENV=production RAILS_GROUPS=assets
