module ApplicationHelper
  def svg_icon(name)
    <<~EOSTRING.html_safe
      <svg class="icon icon-#{name}">
        <use xlink:href="#icon-#{name}"></use>
      </svg>
    EOSTRING
  end
end
