#!/bin/bash
mkdir -p tmp/release > /dev/null
mv public/x_assets public/assets  > /dev/null
rake assets:precompile --trace RAILS_ENV=production
DATE=`date +%Y%m%d%H%M`
echo "--- Assets Comparison ---"
diff tmp/release/manifest.yml public/assets/manifest.yml
echo "--- ---"
