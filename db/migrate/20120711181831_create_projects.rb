class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer   :pid
      t.string    :proposal_url
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
      t.string    :state
      t.decimal   :latitude
      t.decimal   :longitude
      t.string    :subject
      t.string    :resource
      t.datetime  :expiration_date
      t.string    :funding_status 
      t.timestamps
    end
  end
end
