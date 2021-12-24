require 'rails_helper'

describe Admin::ModeratorsController, type: :controller do
  describe 'as an authenticated moderator' do
    include_context 'sign in as', :moderator

    context '#index' do
      it 'renders template :index' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context '#new' do
      it 'renders template :new' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context '#create' do
      let(:new_moderator_params) { attributes_for(:moderator) }

      it 'adds a moderator' do
        expect do
          post :create, params: { moderator: new_moderator_params }
        end.to change(Moderator, :count).by(1)
      end
    end

    context '#edit' do
      let(:moderator) { create(:moderator) }

      it 'renders template :edit' do
        get :edit, params: { id: moderator.id }
      end
    end

    context '#update' do
      let(:new_moderator) { create(:moderator) }
      let(:updated_moderator_name) { 'New Name' }

      it 'updates a moderator' do
        patch :update, params: { id: new_moderator.id, moderator: { name: updated_moderator_name } }
        expect(new_moderator.reload.name).to eq(updated_moderator_name)
      end
    end

    context '#delete' do
      let!(:new_moderator) { create(:moderator) }

      it 'deletes a moderator' do
        expect do
          delete :destroy, params: { id: new_moderator.id }
        end.to change(Moderator, :count).by(-1)
      end
    end
  end

  describe 'as an unauthenticated moderator' do
    context '#index' do
      let(:perform_action) { get :index }

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#new' do
      let(:perform_action) { get :new }

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#create' do
      let(:new_moderator_params) { attributes_for(:moderator) }
      let(:perform_action) do
        post :create, params: { moderator: new_moderator_params }
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session

      it 'does not add a moderator' do
        expect do
          perform_action
        end.to change(Moderator, :count).by(0)
      end
    end

    context '#edit' do
      let(:moderator) { create(:moderator) }
      let(:perform_action) { get :edit, params: { id: moderator.id } }

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#update' do
      let(:moderator) { create(:moderator) }
      let(:updated_moderator_name) { 'New Name' }
      let(:perform_action) do
        patch :update, params: {
          id: moderator.id,
          moderator: { name: :updated_moderator_name }
        }
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session

      it 'does not update a user' do
        perform_action
        expect(moderator.reload.name).to_not eq(updated_moderator_name)
      end
    end

    context '#destroy' do
      let!(:moderator) { create(:moderator) }
      let(:perform_action) do
        delete :destroy, params: { id: moderator.id }
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session

      it 'does not delete a user' do
        expect do
          perform_action
        end.to_not change(Moderator, :count)
      end
    end
  end
end
