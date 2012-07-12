class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
