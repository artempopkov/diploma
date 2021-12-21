RSpec.shared_context 'sign in as moderator', :sign_in_as_moderator do
  let!(:moderator) { FactoryBot.create(:moderator) }

  before { sign_in moderator }
end
