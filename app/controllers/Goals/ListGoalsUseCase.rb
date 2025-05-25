class ListGoalsUseCase
  def initialize(curret_user)
    @curret_user = curret_user
  end
  def call(params, pagination = true)
    goals = apply_filters_in_list(params, pagination)

    goals
  end

  def apply_filters_in_list(params, pagination)
    goals = Goal.all
    goals = goals.filter_by_state(params[:state]).filter_by_title(params[:title]).filter_by_creator(@current_user).order("limit_time ASC")
    
    pagination ? goals.page(params[:page]).per(10) : goals
  end
end
