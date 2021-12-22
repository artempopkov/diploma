RSpec.shared_context 'sign in as' do |model_name|
  let!(:authenticatable_user) { FactoryBot.create(model_name) }

  before { sign_in authenticatable_user }
end
