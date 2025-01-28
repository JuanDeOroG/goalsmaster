class CreateGoalsUseCase
  def initialize(current_user)
    @current_user = current_user
  end

  def call(params)
    goal = Goal.new(params)
    puts "PARAMSS "+params.inspect
    goal.user_id = @current_user.id
    goal.created_by = @current_user.id
    goal.updated_by = @current_user.id

    goal.save
    goal
  end
end
