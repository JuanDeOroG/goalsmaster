class ListTasksUseCase
  def call(params, pagination = true)
    tasks = apply_filters_in_list(params, pagination)

    tasks
  end

  def apply_filters_in_list(params, pagination)
    goal = Goal.find_by(code: params[:goalCode])
    tasks = Task.includes(:goal)
    tasks = tasks.filter_by_name(params[:name])
    tasks = tasks.filter_by_goalId(goal.id)
    # tasks = tasks.filter_by_creator(@curret_user)
    tasks = tasks.order("limit_time ASC")
    pagination ? tasks.page(params[:page]).per(10) : tasks
  end
end
