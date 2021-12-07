require 'rails_helper'

describe Admin::ModeratorsController, type: :controller do
  describe '#index' do
    context 'as an authenticated moderator' do
      let(:moderator) { FactoryBot.create(:moderator) }

      before do
        sign_in moderator
      end

      it 'renders index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'as an unauthenticated moderator' do
      it 'redirects to sign in' do
        get :index
        expect(response).to redirect_to(new_moderator_session_path)
      end
    end
  end

  describe '#create' do
    context 'as an authenticated moderator' do
      let(:moderator) { FactoryBot.create(:moderator) }
      let(:new_moderator) { FactoryBot.attributes_for(:moderator) }

      before do
        sign_in moderator
      end

      it 'adds a moderator' do
        expect do
          post :create, params: { moderator: new_moderator }
        end.to change(Moderator, :count).by(1)
      end
    end

    context 'as unauthenticated moderator' do
      let(:moderator) { FactoryBot.attributes_for(:moderator) }

      it 'does not add a moderator' do
        expect do
          post :create, params: { moderator: moderator }
        end.to change(Moderator, :count).by(0)
      end

      it 'redirects to sign in' do
        post :create, params: { moderator: moderator }
        expect(response).to redirect_to(new_moderator_session_path)
      end
    end
  end

  describe '#update' do
    context 'as an authenticated moderator' do
      let(:moderator) { FactoryBot.create(:moderator) }
      let(:new_moderator) { FactoryBot.create(:moderator) }

      before do
        sign_in moderator
      end

      it 'updates a moderator' do
        patch :update, params: { id: new_moderator.id, moderator: { name: 'New Name' } }
        expect(new_moderator.reload.name).to eq('New Name')
      end
    end

    context 'as an unauthenticated moderator' do
      let(:moderator) { FactoryBot.create(:moderator) }

      it 'does not update a moderator' do
        patch :update, params: { id: moderator.id, moderator: { name: 'New Name' } }
        expect(moderator.reload.name).to_not eq('New Name')
      end

      it 'redirects to sign in' do
        patch :update, params: { id: moderator.id, moderator: { name: 'New Name' } }
        expect(response).to redirect_to(new_moderator_session_path)
      end
    end
  end

  describe '#destroy' do
    context 'as an authenticated moderator' do
      let(:moderator) { FactoryBot.create(:moderator) }
      let!(:new_moderator) { FactoryBot.create(:moderator) }

      before do
        sign_in moderator
      end

      it 'deletes a moderator' do
        expect do
          delete :destroy, params: { id: new_moderator.id }
        end.to change(Moderator, :count).by(-1)
      end
    end

    context 'as an unauthenticated moderator' do
      let!(:moderator) { FactoryBot.create(:moderator) }

      it 'does not delete a moderator' do
        expect do
          delete :destroy, params: { id: moderator.id }
        end.to_not change(Moderator, :count)
      end

      it 'redirects to sign in' do
        delete :destroy, params: { id: moderator.id }
        expect(response).to redirect_to(new_moderator_session_path)
      end
    end
  end
end
