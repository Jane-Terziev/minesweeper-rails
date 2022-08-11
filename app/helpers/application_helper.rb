module ApplicationHelper
  include Pagy::Frontend

  def page_params
    params.permit(:page, :page_size)
  end

  def sort_params
    params.permit(:sort, :direction)
  end
end
