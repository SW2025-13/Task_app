module TasksHelper
  def next_direction(column)
    if params[:sort] == column && params[:direction] == "asc"
      "desc"
    else
      "asc"
    end
  end

  # ▲▼ アイコン表示用
  def sort_icon(column)
    return "" unless params[:sort] == column

    if params[:direction] == "asc"
      " ▲"
    else
      " ▼"
    end
  end
end