require 'rails_helper'

describe Admin::UsersController, type: :controller do
  describe '#index' do
    it 'redirects to sign in' do
      get :index
      expect(response).to redirect_to(new_moderator_session_path)
    end
  end
end
