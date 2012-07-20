class AddUrlToWidget < ActiveRecord::Migration
  def change
    change_column :widgets, :url, :text
  end
end
