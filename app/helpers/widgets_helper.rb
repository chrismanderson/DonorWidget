module WidgetsHelper
  def widget_id_meta(widget)
    tag('meta', name: 'widget_id', content: widget.id)
  end
end
