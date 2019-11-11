require 'rails_helper'

RSpec.describe 'api/subscribe' do


  context 'successfull' do
    def api_call
      get "/api/v1/subscribe"
    end


    it_behaves_like '200'
    it_behaves_like 'json result'

    specify 'returns the token as part of the response' do
      allow(UserService).to receive(:generate_token).and_return("12345")
      api_call
      expect(JSON.parse(response.body)['token']).to be_present
      expect(JSON.parse(response.body)['token']).to eq("12345")
    end
  end

  context 'invalid' do
  end
end



