require 'spec_helper'

describe "Pages" do
  use_vcr_cassette
  describe "when a visitor views the root url" do
    before(:each) do
      visit root_url
    end

    it "displays the homepage" do
      page.should have_content "Easily share the causes you support online."
    end

    describe "the 'make a widget' button" do
      it "takes the visitor to the widget workflow" do
        click_on "Make a widget"
        page.should have_content 'Please paste in '
      end
    end
  end

  describe "URL page" do
    before(:each) do
      visit root_url
      click_on "Make a widget"
    end

    context "a good url" do
      it "moves on to the next step" do
        fill_in "widget[url]", :with => test_url
        click_on "Create Widget"
        page.should have_content test_description
      end
    end
  end

  describe "Choose size page" do
    before(:each) do
      visit root_url
      click_on "Make a widget"
      fill_in "widget[url]", :with => test_url
      click_on "Create Widget"
    end

    it "moves through the workflow when user picks a size" do
      choose('widget[size]')
      click_on "Update Widget"
      page.should have_content 'Background Color'
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