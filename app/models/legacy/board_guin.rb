class BoardGuin < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "board_guin"

end
