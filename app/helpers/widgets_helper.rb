module WidgetsHelper
  def widget_id_meta
    tag('meta', name: 'widget_id', content: @widget.id)
  end
end
