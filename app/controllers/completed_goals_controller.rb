class CompletedGoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = current_user.goals.completed.sorted
    render partial: "goals/complete", locals: {goals: @goals}
  end
end
