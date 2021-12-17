require 'rails_helper'

describe Admin::ModeratorsController, type: :controller do
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

    context '#update' do
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

    context 'delete' do
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
  end

  describe 'as an unauthenticated moderator' do
    context '#index' do
      subject(:perform) do
        get :index
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#create' do

      let(:moderator) { FactoryBot.attributes_for(:moderator) }

      subject(:perform) do
        post :create, params: {
          moderator: moderator
        }
      end

      it 'does not add a moderator' do
        expect do
          perform
        end.to change(Moderator, :count).by(0)
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#update' do
      let(:moderator) { FactoryBot.create(:moderator) }

      subject(:perform) do
        patch :update, params: {
          id: moderator.id,
          moderator: { name: 'New Name' }
        }
      end

      it 'does not update a user' do
        perform
        expect(moderator.reload.name).to_not eq('New Name')
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end

    context '#destroy' do
      let!(:moderator) { FactoryBot.create(:moderator) }

      subject(:perform) do
        delete :destroy, params: {
          id: moderator.id
        }
      end

      it 'does not delete a user' do
        expect do
          perform
        end.to_not change(Moderator, :count)
      end

      include_examples 'redirects to', 'sign in', :new_moderator_session
    end
  end
end
