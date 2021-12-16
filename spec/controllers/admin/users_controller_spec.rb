require 'rails_helper'

describe Admin::UsersController, type: :controller do
  describe 'as an authenticated moderator' do
    context '#index' do
      let(:moderator) { FactoryBot.create(:moderator) }

      before do
        sign_in moderator
      end

      it 'renders index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context '#create' do
      let(:moderator) { FactoryBot.create(:moderator) }
      let(:user) { FactoryBot.attributes_for(:user) }

      before do
        sign_in moderator
      end

      it 'adds a user' do
        expect do
          post :create, params: { user: user }
        end.to change(User, :count).by(1)
      end
    end

    context '#update' do
      let(:moderator) { FactoryBot.create(:moderator) }
      let(:user) { FactoryBot.create(:user) }

      before do
        sign_in moderator
      end

      it 'updates a user' do
        patch :update, params: { id: user.id, user: { name: 'New Name' } }
        expect(user.reload.name).to eq('New Name')
      end
    end

    context 'delete' do
      let(:moderator) { FactoryBot.create(:moderator) }
      let!(:user) { FactoryBot.create(:user) }

      before do
        sign_in moderator
      end

      it 'deletes a user' do
        expect do
          delete :destroy, params: { id: user.id }
        end.to change(User, :count).by(-1)
      end
    end
  end

  describe 'as an unauthenticated moderator' do
    context '#index' do
      it 'redirects to sign in' do
        get :index
        expect(response).to redirect_to(new_moderator_session_path)
      end
    end

    context '#create' do
      let(:user) { FactoryBot.attributes_for(:user) }

      subject(:perform) do
        post :create, params: {
          user:user
        }
      end

      it 'does not add a user' do
        expect do
          perform
        end.to change(User, :count).by(0)
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#update' do
      let(:user) { FactoryBot.create(:user) }

      subject(:perform) do
        patch :update, params: {
          id: user.id,
          user: { name: 'New Name' }
        }
      end

      it 'does not update a user' do
        perform
        expect(user.reload.name).to_not eq('New Name')
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#destroy' do
      let!(:user) { FactoryBot.create(:user) }

      subject(:perform) do
        delete :destroy, params: {
          id: user.id
        }
      end

      it 'does not delete a user' do
        expect do
          perform
        end.to_not change(User, :count)
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end
  end
end
