class Rates < ActiveRecord::Migration
	change_table :rates do |t|
		t.remove :dateOn
	end
end
