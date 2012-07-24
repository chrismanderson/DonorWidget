require 'spec_helper'

describe "Pages" do
  use_vcr_cassette
  describe "when a visitor views the root url" do
    it "displays the homepage" do
      visit root_url
      page.should have_content "Easily share the causes you support online."
    end
  end

  describe "when a visitor wants to create a widget" do
    it "walks the user through widget creation" do
      visit root_url
      click_on "Make a widget"
      page.should have_content 'Please paste in'
      fill_in "widget[url]", :with => test_url
      click_on "Create Widget"
      page.should have_content test_description
      choose('widget[size]')
      click_on "Update Widget"
      page.should have_content "Background Color"
      click_on "Finish"
      page.should have_content test_description
      page.should have_content "Copy and"
    end
  end
end