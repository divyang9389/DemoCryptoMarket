module ApplicationHelper
  def page_index(index, count=10)
    "<td>#{index+1}</td>".html_safe
  end
end
