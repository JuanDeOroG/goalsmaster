class CreateGoalsUseCase
  def initialize(current_user)
    @current_user = current_user
  end

  def call(params)
    goal = Goal.new(params)
    goal.setCreator(goal, @current_user)

    goal.save
    goal
  end
end
