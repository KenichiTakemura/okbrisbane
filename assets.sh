rake assets:precompile --trace RAILS_ENV=production
cd public
tar jcvf assets.tar.bz2 assets
