module BoardsHelper
  def sort_link(label:, sort:)
    query_params = {**page_params, data: { turbo_action: 'advance' }}
    link_to(label, boards_path(sort: sort, direction: next_direction(sort), **query_params))
  end

  def next_direction(sort)
    if params[:sort] == sort
      params[:direction] == 'asc' ? 'desc' : 'asc'
    else
      'asc'
    end
  end

  def sort_indicator
    params[:direction] == 'asc' ? arrow_direction = 'up' : arrow_direction = 'down'
    tag.i(class: "fa-solid fa-arrow-#{arrow_direction}")
  end

  def display_date(date)
    date.strftime("%d-%m-%Y %H:%M")
  end
end
