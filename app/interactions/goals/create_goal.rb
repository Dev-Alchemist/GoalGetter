class CreateGoal < ActiveInteraction::Base
  string :title
  string :description
  date :due_date
  string :priority, default: "inclusion"
  boolean :completed, default: false
  record :user

  def to_model
    @goal ||= Goal.new
  end

  def execute
    @goal = Goal.new(inputs)
    errors.merge!(@goal.errors) unless @goal.save
    @goal
  end
end
