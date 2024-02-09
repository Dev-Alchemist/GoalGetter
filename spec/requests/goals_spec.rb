require "rails_helper"

RSpec.describe "/goals", type: :request do
  fixtures :goals, :users

  let(:user) { users(:test) }
  let(:valid_attributes) { {title: "High Priority Goal", priority: "Low", due_date: 1.week.from_now, description: "Another one", user: user} }
  let(:invalid_attributes) { {title: "", priority: "Low", due_date: 1.week.from_now} }

  describe "GET /index" do
    it "renders a successful response" do
      sign_in user
      Goal.create! valid_attributes
      get goals_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      sign_in user
      goal = Goal.create! valid_attributes
      get goal_url(goal)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      sign_in user
      get new_goal_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      sign_in user
      goal = Goal.create! valid_attributes
      get edit_goal_url(goal)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before do
      sign_in user
    end

    context "with valid parameters" do
      it "creates a new Goal" do
        expect {
          post goals_url, params: {goal: valid_attributes}
        }.to change(Goal, :count).by(1)
      end

      it "redirects to the created goal" do
        post goals_url, params: {goal: valid_attributes}
        expect(response).to redirect_to(goal_url(Goal.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Goal" do
        expect {
          post goals_url, params: {goal: invalid_attributes}
        }.to change(Goal, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post goals_url, params: {goal: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    before do
      sign_in user
    end

    context "with valid parameters" do
      let(:new_attributes) {
        {title: "Updated Goal Title", description: "Updated description"}
      }

      it "updates the requested goal" do
        goal = Goal.create! valid_attributes
        patch goal_url(goal), params: {goal: new_attributes}
        goal.reload
        expect(goal.title).to eq("Updated Goal Title")
        expect(goal.description).to eq("Updated description")
      end

      it "redirects to the goal" do
        goal = Goal.create! valid_attributes
        patch goal_url(goal), params: {goal: new_attributes}
        goal.reload
        expect(response).to redirect_to(goal_url(goal))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        goal = Goal.create! valid_attributes
        patch goal_url(goal), params: {goal: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      sign_in user
    end

    it "destroys the requested goal" do
      goal = Goal.create! valid_attributes
      expect {
        delete goal_url(goal)
      }.to change(Goal, :count).by(-1)
    end

    it "redirects to the goals list" do
      goal = Goal.create! valid_attributes
      delete goal_url(goal)
      expect(response).to redirect_to(goals_url)
    end
  end
end
