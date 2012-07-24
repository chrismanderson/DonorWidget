require 'spec_helper'

describe WidgetsHelper do
  describe "#widget_id_meta" do
    it 'returns a meta tag for a given id' do
      include WidgetsHelper
      widget = Widget.create(url: "sample_url")
      widget.update_attribute(:id, 1337)
      widget_id_meta(widget).should == "<meta content=\"1337\" name=\"widget_id\" />"
    end
  end
end
