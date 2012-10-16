class Sellnbuy < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "sellnbuy"

end
