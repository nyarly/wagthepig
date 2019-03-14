module ApplicationHelper
  def svg_icon(name)
    "<svg class=\"icon icon-#{name}\"><use xlink:href=\"#icon-#{name}\"></use></svg>".html_safe
  end
end
