class Widget < ActiveRecord::Base
  attr_accessible :project_id, :user_id

  belongs_to :project
  belongs_to :user

  def method_missing(meth, *args, &block)
    if project.respond_to?(meth)
      project.send(meth, *args, &block)
    else
      super
    end
  end

  def respond_to?(meth, include_private = false)
    self.project.respond_to?(meth) || super
  end
end



 # create_table "projects", :force => true do |t|
 #    t.integer  "project_id"
 #    t.string   "proposal_url"
 #    t.string   "proposal_raw_url"
 #    t.string   "fund_url"
 #    t.string   "image_url"
 #    t.string   "title"
 #    t.string   "short_description"
 #    t.string   "fulfillment_trailer"
 #    t.integer  "percent_funded"
 #    t.decimal  "cost_to_complete"
 #    t.decimal  "total_price"
 #    t.string   "teacher_name"
 #    t.string   "grade_level"
 #    t.string   "poverty_level"
 #    t.string   "school"
 #    t.string   "city"
 #    t.integer  "zip"
 #    t.string   "state_abbr"
 #    t.decimal  "latitude"
 #    t.decimal  "longitude"
 #    t.string   "state"
 #    t.string   "subject"
 #    t.string   "resource"
 #    t.datetime "expiration_date"
 #    t.string   "funding_status"
 #    t.datetime "created_at",          :null => false
 #    t.datetime "updated_at",          :null => false
 #  end
