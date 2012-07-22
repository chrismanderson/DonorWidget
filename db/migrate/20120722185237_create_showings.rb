class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      t.integer :widget_id

      t.timestamps
    end
  end
end
