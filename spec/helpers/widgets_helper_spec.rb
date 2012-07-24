require 'spec_helper'

describe WidgetsHelper do
  let!(:klass) { Class.new.tap {|k| k.send(:include, WidgetsHelper)}}

  context 'widget with id 1337' do

    let!(:instance) do
      klass.new.tap do |i|
        widget = double().tap { |d| d.stub(:id) { 1337 } }
        i.instance_variable_set('@widget', widget)
      end
    end

    it 'returns a meta tag for a given id' do
      instance.widget_id_meta.should match(/^<\s*meta\s*\\\s?>/)
      instance.widget_id_meta.should match(/name\s?=\s?['"]widget_id['"]/)
      instance.widget_id_meta.should match(/content\s?=\s?['"]1337['"]/)
    end
  end
end


# module WidgetsHelper
#   def widget_id_meta
#     tag('meta', name: 'widget_id', content: @widget.id)
#   end
# end
