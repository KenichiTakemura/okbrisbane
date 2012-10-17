class BoardStoryTravel < ActiveRecord::Base
  establish_connection "legacy"
  set_table_name "board_story_travel"

end
