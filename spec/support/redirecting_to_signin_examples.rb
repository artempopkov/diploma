RSpec.shared_examples 'redirects to' do |to, path|
  it "it redirects to #{to}" do
    perform
    expect(response).to redirect_to(path)
  end
end
