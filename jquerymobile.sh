rm -rf tmp/jquery.mobile
mkdir -p tmp/jquery.mobile
cd tmp/jquery.mobile
mv ~/"ダウンロード"/jquery.mobile.custom.zip .
unzip jquery.mobile.custom.zip
cp -p jquery.mobile.custom.min.js ../../vendor/assets/javascripts/
cp -p jquery.mobile.custom.structure.min.css ../../vendor/assets/stylesheets/
cp -p jquery.mobile.custom.theme.min.css ../../vendor/assets/stylesheets/
cd ../../
rm -rf tmp/jquery.mobile
