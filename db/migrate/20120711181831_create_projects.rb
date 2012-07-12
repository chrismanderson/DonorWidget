class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer   :project_id
      t.string    :proposal_url
      t.string    :proposal_raw_url
      t.string    :fund_url
      t.string    :image_url
      t.string    :title
      t.string    :short_description
      t.string    :fulfillment_trailer
      t.integer   :percent_funded
      t.decimal   :cost_to_complete
      t.decimal   :total_price
      t.string    :teacher_name
      t.string    :grade_level
      t.string    :poverty_level
      t.string    :school
      t.string    :city
      t.integer   :zip
      t.string    :state_abbr
      t.decimal   :latitude
      t.decimal   :longitude
      t.string    :state
      t.string    :subject
      t.string    :resource
      t.datetime  :expiration_date
      t.string    :funding_status 
      t.timestamps
    end
  end
end
