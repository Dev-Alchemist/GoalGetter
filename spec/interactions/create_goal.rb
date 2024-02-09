require "rails_helper"

RSpec.describe CreateGoal do
  fixtures :users

  describe "#execute" do
    let(:title) { "Test Goal" }
    let(:description) { "This is a test goal description." }
    let(:due_date) { 1.week.from_now }
    let(:priority) { "low" }
    let(:completed) { false }
    let(:user) { users(:test) }

    subject(:create_goal) do
      described_class.run(
        title: title,
        description: description,
        due_date: due_date,
        priority: priority,
        completed: completed,
        user: user
      )
    end
  end
end
