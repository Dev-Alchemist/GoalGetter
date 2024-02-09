class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update destroy]

  def index
    @goals = current_user.goals.sorted
  end

  def show
  end

  def new
    @goal = CreateGoal.new
  end

  def edit
  end

  def create
    @goal = CreateGoal.run(goal_params.merge(user: current_user))

    if @goal.valid?
      redirect_to @goal, notice: "Your Goal has been successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: "Your Goal has been successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_url, notice: "Goal was successfully destroyed."
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:title, :description, :due_date, :priority, :completed)
  end
end
