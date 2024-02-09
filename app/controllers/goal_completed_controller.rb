class GoalCompletedController < ApplicationController
  before_action :authenticate_user!
  before_action :set_goal

  def create
    @goal.update(completed: true)

    redirect_to goals_path, notice: "Goal completed successfully."
  end

  private

  def set_goal
    @goal = Goal.find(params[:goal_id])
  end
end
