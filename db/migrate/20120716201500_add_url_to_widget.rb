class AddUrlToWidget < ActiveRecord::Migration
  def change
    add_column :widgets, :url, :text
  end
end
