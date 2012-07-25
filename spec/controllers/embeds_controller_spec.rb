require 'spec_helper'

describe EmbedsController do
  use_vcr_cassette
  before(:each) do
    @widget = Widget.create!(url: "http://www.donorschoose.org/project/integration-station-creating-daily-sens/754133/")
  end

  context "#show" do
    def app
      EmbedsController.action(:show)
    end

    it "returns success on create" do
      Widget.stub(:find).and_return(@widget)
      get :show, id: @widget.id
      response.should render_template("show")
    end
  end
end
