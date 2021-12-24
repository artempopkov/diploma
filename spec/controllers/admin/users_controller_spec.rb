require 'rails_helper'

describe Admin::UsersController, type: :controller do
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
      let(:user) { attributes_for(:user) }

      it 'adds a user' do
        expect do
          post :create, params: { user: user }
        end.to change(User, :count).by(1)
      end
    end

    context '#edit' do
      let(:user) { create(:user) }

      it 'renders template :edit' do
        get :edit, params: { id: user.id }
      end
    end

    context '#update' do
      let(:user) { create(:user) }
      let(:updated_user_name) { 'New Name' }

      it 'updates a user' do
        patch :update, params: { id: user.id, user: { name: updated_user_name } }
        expect(user.reload.name).to eq(updated_user_name)
      end
    end

    context '#delete' do
      let!(:user) { create(:user) }

      it 'deletes a user' do
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
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
      let(:user) { attributes_for(:user) }
      let(:perform_action) { post :create, params: { user: user } }

      include_examples 'redirects to', 'sign in', :new_moderator_session

      it 'does not add a user' do
        expect { perform_action }.to_not change(User, :count)
      end
    end

    context '#edit' do
      let(:user) { create(:user) }
      let(:perform_action) { get :edit, params: { id: user.id } }

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#update' do
      let(:user) { create(:user) }
      let(:updated_user_name) { 'New Name' }
      let(:user_params) { { id: user.id, user: { name: updated_user_name } } }
      let(:perform_action) { patch :update, params: user_params }

      include_examples 'redirects to', 'sign in', :new_moderator_session

      it 'does not update a user' do
        perform_action
        expect(user.reload.name).to_not eq(updated_user_name)
      end
    end

    context '#destroy' do
      let!(:user) { create(:user) }
      let(:perform_action) do
        delete :destroy, params: { id: user.id }
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session

      it 'does not delete a user' do
        expect { perform_action }.to_not change(User, :count)
      end
    end
  end
end
