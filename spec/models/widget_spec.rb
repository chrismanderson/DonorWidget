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

  describe "#increment_show_count" do
    before do
      Redis.stub(:new).and_return(MockRedis.new)
    end

    it "increments the count of view in Redis" do
      REDIS.should_receive(:lpush)
      @widget.increment_show_count
    end
  end

  describe "#total_clicks" do
    it "queries the length of the clicks list in REDIS" do
     REDIS.should_receive(:llen).with"widget_#{@widget.id}_clicks" 
     @widget.total_clicks
    end
  end

  describe "#total_showing" do
    it "queries the length of the views list in REDIS" do
     REDIS.should_receive(:llen).with"widget_#{@widget.id}_show" 
     @widget.total_showings
    end
  end

  describe "embed code" do
    it "returns the correct embed string" do
      @widget.embed_code.should == "<script type='text/javascript' src='http://#{RAW_URL}/embeds/#{@widget.id}.js'></script>"
    end
  end

  describe "#method_missing" do
    it "calls to super if a key is not found" do
      expect { @widget.tester }.to raise_error NoMethodError
    end
  end

  describe "#funding_needed" do
    it "returns a float value" do
      @widget.funding_needed.should be_a Float
    end
  end

  describe "#school_split" do
    it "returns the school name split by spaces" do
      @widget.stub(:school).and_return("My School")
      @widget.school_split.should == ["My", "School"]
    end
  end

  describe "formatted_school" do
    it "returns the last word of the school" do
      @widget.stub(:school).and_return("My School Awesome")
      @widget.formatted_school.should == "Awesome"
    end
  end

  describe "formatted_name" do
    it "returns the school without spaces and the last element" do
      @widget.stub(:school).and_return("My School Awesome")
      @widget.formatted_name.should == "MySchool"
    end
  end

  describe "#is_funded" do
    it "returns true or false if the project is funded" do
      @widget.stub(:funding_status).and_return("funded")
      @widget.is_funded?.should be_true
    end
  end
end
