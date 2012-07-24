class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :url
      t.string :background_color, :default => '#20242b'
      t.string :size
      t.string :rollover_method
      t.boolean :archived
      t.timestamps
    end
  end
end
