require_dependency "Goals/CreateGoalsUseCase"
require_dependency "Goals/ListGoalsUseCase"

class GoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = ListGoalsUseCase.new().call(params)
    @goal = Goal.new
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
    if goal.update(goal_params)
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
