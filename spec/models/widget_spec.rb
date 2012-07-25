require 'spec_helper'

describe Widget do
  use_vcr_cassette
  before(:each) do
    @widget = Widget.create!(url: "http://www.donorschoose.org/project/integration-station-creating-daily-sens/754133/")
    REDIS.flushall
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
      @widget.add_showing
    end
  end

  describe "#total_clicks" do
    it "queries the length of the clicks list in REDIS" do
     REDIS.should_receive(:llen).with"#{@widget.click_key}"
     @widget.total_clicks
    end
  end

  describe "#total_showing" do
    it "queries the length of the views list in REDIS" do
     REDIS.should_receive(:llen).with"#{@widget.showing_key}" 
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

  describe "#is_funded" do
    it "returns true or false if the project is funded" do
      @widget.stub(:funding_status).and_return("funded")
      @widget.is_funded?.should be_true
    end
  end

  describe "#font_color" do
  
    it "returns 'white' for a dark-colored widget" do
      @widget.stub(:background_color).and_return("#336699")
      @widget.font_color.should == "white"
    end

    it "returns 'black' for a light-colored widget" do
      @widget.stub(:background_color).and_return("#FFCC99")
      @widget.font_color.should == "black"
    end

  end

  context "archving from redis" do
    describe ".archive_clicks" do
      it "converts clicks stored in redis to clicks stored in ActiveRecord" do
        @widget.add_click
        @widget.total_clicks.should == 1
        @widget.cached_clicks.size.should == 1
        Widget.archive_clicks
        @widget.total_clicks.should == 1
        @widget.cached_clicks.size.should == 0
      end
    end

    describe ".archive_showings" do
      it "converts showings stored in redis to clicks stored in ActiveRecord" do
        @widget.add_showing
        @widget.total_showings.should == 1
        @widget.cached_showings.size.should == 1
        Widget.archive_showings
        @widget.total_showings.should == 1
        @widget.cached_showings.size.should == 0
      end
    end
  end
end
