class HappyMember < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "happy_member"

end
