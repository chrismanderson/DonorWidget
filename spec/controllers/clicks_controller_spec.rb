require 'spec_helper'

describe ClicksController do
  use_vcr_cassette
  before(:each) do
    @widget = Widget.create!(url: "http://www.donorschoose.org/project/integration-station-creating-daily-sens/754133/")
  end

  context "#create" do
    def app
      ClicksController.action(:create)
    end

    it "returns success on create" do
      Widget.stub(:find).and_return(@widget)
      post :create, :format => :json 
      JSON.parse(response.body)['status'].should == 'ok'
    end

    it 'calls the #add_click method on the widget' do
      Widget.stub(:find).and_return(@widget)
      @widget.should_receive(:add_click)
      post :create, :format => :json
    end
  end
end
