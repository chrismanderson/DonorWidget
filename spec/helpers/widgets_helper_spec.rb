require 'spec_helper'

describe WidgetsHelper do
  describe "#widget_id_meta" do
    it 'returns a meta tag for a given id' do
      @widget = Widget.create(url: "sample_url")
      @widget.update_attribute(:id, 1337)
      widget_id_meta(@widget).should == "<meta content=\"1337\" name=\"widget_id\" />"
    end
  end

  describe "#school_split" do
    it "returns the school name split by spaces" do
      @widget = Widget.create(url: "sample_url")
      @widget.stub(:school).and_return("My School")
      #school_split(@widget).should == ["My", "School"]
    end
  end

  describe "formatted_school" do
    it "returns the last word of the school" do
      @widget = Widget.create(url: "sample_url")
      @widget.stub(:school).and_return("My School Awesome")
      formatted_school(@widget).should == "Awesome"
    end
  end

  describe "formatted_name" do
    it "returns the school without spaces and the last element" do
      @widget = Widget.create(url: "sample_url")
      @widget.stub(:school).and_return("My School Awesome")
      formatted_name(@widget).should == "MySchool"
    end
  end
end
