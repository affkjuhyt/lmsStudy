require 'rails_helper'

RSpec.describe UserCoursesController, type: :controller do
  let!(:current_user) { FactoryBot.create :user }
  let!(:current_user_course) { current_user.user_courses.first }
  let!(:params) { FactoryBot.attributes_for :user_course }

  context "when user logged in" do
    before { log_in current_user }

    describe "POST #create" do
      context "when valid param" do
        before { post :create, params: { user_course: params } }

        it "should redirect to course url" do
          expect(response).to redirect_to @course
        end

        it "should return success message" do
          expect(flash[:success]).to eq I18n.t("user_courses.success_created")
        end
      end
    end

    context "when user_course exists" do
      context "when user_course belongs to current user" do
        describe "PATCH #update" do
          context "when valid param" do
            before { patch :update, params: { id: current_user_course.id, user_course: params } }

            it "should update and redirect to course" do
              expect(response).to redirect_to @course
            end

            it "should return success message" do
              expect(flash[:success]).to eq I18n.t("user_courses.success_updated")
            end
          end
        end
      end
    end
  end
end
