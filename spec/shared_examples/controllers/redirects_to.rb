RSpec.shared_examples 'redirects to' do |to, path|
  it "redirects to #{to}" do
    perform_action
    expect(response).to redirect_to(path)
  end
end
