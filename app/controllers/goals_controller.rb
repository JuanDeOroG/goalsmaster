require_dependency "Goals/CreateGoalsUseCase"
require_dependency "Goals/ListGoalsUseCase"
require_dependency "Tasks/DeleteAllTasksForGoalUseCase"

class GoalsController < ApplicationController
  before_action :authenticate_user!
  skip_forgery_protection only: :index

  def index
    @goals = ListGoalsUseCase.new(current_user).call(params)
    @goal = Goal.new

    respond_to do |format|
      format.html { render :index } # Renderiza la vista HTML normalmente
      format.js { render partial: "goals/partials/goalList", locals: { goals: @goals } } # Devuelve el partial
    end
  end

  def create
    createGoalsUseCase = CreateGoalsUseCase.new(current_user)
    goal = createGoalsUseCase.call(goal_params)

    if !goal.errors
      redirect_to goals_path, notice: "Goal was created successfully"
    else
      error_messages = goal.errors.full_messages.join(", ")
      redirect_to goals_path, alert: "Goal was not created: #{error_messages}"
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render partial: "goals/partials/form", locals: { goal: @goal }
  end

  def update
    goal = Goal.find(params[:id])
    goal.updated_by = current_user.id
    if goal.update(goal_params)
      DeleteAllTasksForGoalUseCase.new.call(params[:id]) # Change the state of all tasks for the goal to 2 (deleted)
      redirect_to goals_path, notice: "Goal was updated successfully"
    else
      error_messages = goal.errors.full_messages.join(", ")
      redirect_to goals_path, alert: "Goal was not updated: #{error_messages}"
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    if goal.update(state: 2)
      redirect_to goals_path, notice: "Goal was deleted successfully"
    else
      error_messages = goal.errors.full_messages.join(", ")
      redirect_to goals_path, alert: "Goal was not Deleted: #{error_messages}"
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :limit_time)
  end
end
