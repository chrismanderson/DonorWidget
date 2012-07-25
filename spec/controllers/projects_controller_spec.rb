require 'spec_helper'

describe ProjectsController do
  use_vcr_cassette
  before(:each) do
    @widget = Widget.create!(url: "http://www.donorschoose.org/project/integration-station-creating-daily-sens/754133/")
  end

  context "#random" do
    def app
      ProjectsController.action(:random)
    end

    it "returns a random DonorsChoose URL" do
      donors = double('DonorsChoose')
      DonorsChoose::Project.stub(:by_poverty_level).and_return([donors])
      donors.stub(:proposalURL).and_return(test_url)
      get 'random'
      JSON.parse(response.body)['url'].should == test_url
    end
  end

  context "#show" do
    def app
      ProjectsController.action(:show)
    end

    it "returns success if a donors choose project exists" do
      donors = double('DonorsChoose')
      DonorsChoose::Project.stub(:by_id).and_return(donors)
      donors.stub(:by_id).and_return(test_url)
      get :show, id: 754133
      JSON.parse(response.body)['status'].should == 'success'
    end

    it "returns failure if a donors choose project does not exist" do
      donors = double('DonorsChoose')
      DonorsChoose::Project.stub(:by_id).and_return(nil)
      donors.stub(:by_id).and_return(test_url)
      get :show, id: 3434
      JSON.parse(response.body)['status'].should == 'bad_request'
    end
  end
end
