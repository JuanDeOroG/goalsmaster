class ListGoalsUseCase
  def call(params, pagination = true)
    goals = apply_filters_in_list(params, pagination)

    goals
  end

  def apply_filters_in_list(params, pagination)
    goals = Goal.all
    # goals = goals.filterByTitle
    # goals = goals.filterByDescription
    # goals = goals.filterBy
    goals.page(params[:page]).per(10)
  end
end
