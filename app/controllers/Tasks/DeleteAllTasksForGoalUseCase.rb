class DeleteAllTasksForGoalUseCase
  def call(params)
    Task.where(goal_id: params[:goal_id]).update_all(state: 2)
  end
end
