require 'rails_helper'

RSpec.describe 'api/v1/create_video' do

  context "create video" do
    def api_call params
      post "/api/v1/create_video", params: params
    end

    let(:user) { create :user }
    let(:video) { create :video, user: user }
    let(:url) { "some/url" }


    context 'successfully' do

      let(:params) {{ token: user.token, file: url }}

      it_behaves_like '200'
      it_behaves_like 'json result'
      it 'returns the link to the uploaded video' do
        allow(VideoService).to receive(:create_new_video).with(url, user).and_return(video)
        allow(video).to receive(:save).and_return(true)
        allow(video).to receive(:url).and_return(url)
        api_call params

        expect(JSON.parse(response.body)['url']).to be_present
      end
    end

  end
end



