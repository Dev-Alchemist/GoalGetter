class IncompleteGoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = current_user.goals.incomplete.sorted
    render partial: "goals/incomplete", locals: {goals: @goals}
  end
end
