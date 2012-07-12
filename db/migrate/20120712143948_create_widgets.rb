class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.integer :user_id
      t.string :url
      t.string :background_color
      t.string :size
      t.string :rollover_method
      t.boolean :archived

      t.timestamps
    end
  end
end
