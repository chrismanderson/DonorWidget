require 'spec_helper'

describe Widget do
  use_vcr_cassette
  before(:each) do
    @widget = Widget.create!(url: "http://www.donorschoose.org/project/integration-station-creating-daily-sens/754133/")
  end
  
  it "parses its pid from its url" do    
    @widget.pid.should == "754133"
  end

  it "retrieves its title from the DonorsChoose API" do
    @widget.title.should == "Integration Station, Creating Daily Sensory Experiences"
  end

  it "caches data in a Redis store" do
    @widget.send(:update_cache)
    @widget.send(:cache_current?).should be_true
  end

end
