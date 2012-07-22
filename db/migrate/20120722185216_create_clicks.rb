class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.integer :widget_id

      t.timestamps
    end
  end
end
