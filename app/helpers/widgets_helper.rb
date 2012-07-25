module WidgetsHelper
  def widget_id_meta(widget)
    tag('meta', name: 'widget_id', content: widget.id)
  end

  def school_split(widget)
    widget.school.split(" ")
  end

  def format_school(widget)
    (school_split(widget)[-1]).html_safe
  end

  def format_name(widget)
    (school_split(widget)[0...-1].join("")).html_safe
  end
end
