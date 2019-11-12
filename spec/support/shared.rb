RSpec.shared_examples 'json result' do
  specify 'returns JSON' do
    api_call params
    expect { JSON.parse(response.body) }.not_to raise_error
  end
end

RSpec.shared_examples '200' do
  specify 'returns 200' do
    api_call params
    expect(response.status).to eq(200)
  end
end
