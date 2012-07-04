rm -f log/test.log
target=$1
method=$2
if [ -z $method ]
then
	ruby -Itest test/unit/${target}_test.rb
else
	ruby -Itest test/unit/${target}_test.rb -n $method
fi
