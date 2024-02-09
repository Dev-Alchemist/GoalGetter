require "rails_helper"

RSpec.describe Goal, type: :model do
  fixtures :goals, :users

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(80) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
    it { is_expected.to validate_presence_of(:due_date) }
    it { is_expected.to validate_presence_of(:priority) }

    describe "due_date_within_range" do
      let(:valid_goal) { goals(:low_priority_goal) }
      let(:invalid_due_date) { goals(:high_priority_goal) }

      it "is valid with a due date within the range" do
        expect(valid_goal).to be_valid
      end

      it "is invalid with a due date in the past" do
        invalid_due_date.due_date = 1.day.ago
        expect(invalid_due_date).to be_invalid
      end

      it "is invalid with a due date too far in the future" do
        invalid_due_date.due_date = 2101.years.from_now
        expect(invalid_due_date).to be_invalid
      end
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
