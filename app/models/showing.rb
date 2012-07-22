class Showing < ActiveRecord::Base
  attr_accessible :widget_id

  belongs_to :widget
end
