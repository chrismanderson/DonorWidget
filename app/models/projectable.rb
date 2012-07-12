module Projectable
	def self.included(base)
    base.class_eval do
      attr_accessible :pid, :proposal_url, :proposal_raw_url, 
      :fund_url, :image_url,:title, :short_description,
      :fulfillment_trailer,:percent_funded,:cost_to_complete,
      :total_price,:teacher_name,:grade_level,:poverty_level,
      :school,:city,:zip,:state,:latitude,:longitude,:subject,
      :resource,:expiration_date,:funding_status 
    end
  end
end