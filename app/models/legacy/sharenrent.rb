class Sharenrent < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "sharenrent"

end
