mkdir -p tmp/bootstrap
cd tmp/bootstrap
mv ~/Downloads/bootstrap.zip .
unzip bootstrap.zip
if [ -e "css/error.txt" ]
then
echo "Cannot continue due to an error"
cat css/error.txt
echo ""
rm -rf tmp/bootstrap
exit
fi
#cp -p js/bootstrap.js ../../vendor/assets/javascripts/bootstrap.js
#cp -p css/bootstrap.css ../../vendor/assets/stylesheets/bootstrap.css
#cp -p js/bootstrap.min.js ../../../admin.okbrisbane/vendor/assets/javascripts/bootstrap.js
#cp -p css/bootstrap.min.css ../../../admin.okbrisbane/vendor/assets/stylesheets/bootstrap.css
cd ../../
rm -rf tmp/bootstrap
