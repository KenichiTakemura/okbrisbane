echo "Rate Cleanup starts"
rails runner -e development RateConfig.cleanup
echo "Rate Cleanup End with status $?"
