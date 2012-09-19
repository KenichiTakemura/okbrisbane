class CreateWeathers < ActiveRecord::Migration
  def change
    create_table(:weathers, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.datetime :issuedOn
      t.datetime :dateOn
      t.string :location
      t.integer :country
      t.string :forecast
      t.string :summary
      t.integer :min
      t.integer :max
      t.string :warning
      t.timestamps
    end
  end
end
