class Taxnsuper < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "taxnsuper"

end
