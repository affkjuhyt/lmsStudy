require 'rails_helper'

RSpec.describe ReviewCoursesController, type: :controller do
  let!(:current_user) { FactoryBot.create :user }
  let!(:current_review_course) { current_user.review_courses.first }
  let!(:params) { FactoryBot.attributes_for :review_course }

  context 'when user logged in' do
    before { log_in current_user }

    describe 'POST #create' do
      context 'when valid param' do
        before { review_course :create, params: { review_course: params } }

        it 'should redirect to review' do
          expect(response).to redirect_to @review_course
        end
      end

      context 'when invalid param' do
        before { review_course :create, params: { review_course: { comment: "" } } }

        it 'should render view new' do
          expect(response).to redirect_to root_path
        end

        it 'should return error message' do
          expect(flash[:error]).to eq I18n.t('login.first')
        end
      end
    end

    context 'when review_courses exists' do
      context 'when review_course belongs to current user' do
        describe 'GET #edit' do
          before { get :edit, params: { id: review_course.id } }

          it 'should render view edit' do
            expect(response).to render_template :edit
          end
        end

        describe 'PATCH #update' do
          context 'when valid param' do
            before { patch :update, params: { id: current_review_course.id, review_course: params } }
          end
        end

        describe 'DELETE #destroy' do
          context 'when valid param' do
            before { delete :destroy, params: { id: review_course.id } }
  
            it 'redirect to review_course' do
              expect(response).to redirect_to review_courses_url
            end
          end
        end
      end
    end
  end
end
