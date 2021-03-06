require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe 'api/v1/create_video' do

  context "create video" do

    before do
      Sidekiq::Testing.inline!
      allow_any_instance_of(Video).to receive(:process_video).and_return(true)
    end

    def api_call params
      post "/api/v1/create_video", params: params
    end

    let(:user) { create :user }
    let(:video) { build :video, user: user }
    let(:url) { "some/url" }
    let(:start_time) { "3" }
    let(:end_time) { "10" }
    let(:original_params) {{ token: user.token, file: url, start_time: start_time, end_time: end_time }}

    context 'successfully' do

      let(:params) { original_params }

      it_behaves_like '200'
      it_behaves_like 'json result'

      it 'returns the link to the uploaded video' do
        allow(video).to receive(:url).and_return(url)
        allow(VideoService).to receive(:build_new_video).with(url, user, start_time, end_time).and_return(video)


        api_call params

        expect(video.reload.file_processing).to eq(2)
        expect(JSON.parse(response.body)['url']).to be_present
        expect(JSON.parse(response.body)['url']).to eq(url)
        expect(JSON.parse(response.body)['duration']).to be_present
        expect(JSON.parse(response.body)['id']['$oid']).to eq(video.id.to_s)
      end
    end

    context 'failed because' do

      describe 'token missing' do
        let(:params) { original_params.except :token }
        it_behaves_like '401'
        it_behaves_like 'contains error msg', 'access denied'
      end

      describe 'incorrect token' do
        let(:params) {{ token: "11111", file: url, start_time: start_time, end_time: end_time }}
        it_behaves_like '401'
        it_behaves_like 'contains error msg', 'access denied'
      end

      describe 'file missing' do
        let(:params) { original_params.except :file }
        it_behaves_like '400'
        it_behaves_like 'contains error msg', 'file is missing'
      end

    end
  end

  context "retry video processing" do
    before do
      Sidekiq::Testing.inline!
      allow_any_instance_of(Video).to receive(:process_video).and_return(true)
    end

    def api_call params
      put "/api/v1/retry_processing_video", params: params
    end

    let(:user) { create :user }
    let(:video) { create :video, user: user }
    let(:url) { "some/url" }

    context 'successfully' do

      let(:params) { {token: user.token, video_id: video.id} }

      it_behaves_like '200'
      it_behaves_like 'json result'

      it 'returns the link to the uploaded video' do
        allow_any_instance_of(Video).to receive(:url).and_return(url)
        api_call params

        expect(video.reload.file_processing).to eq(2)
        expect(JSON.parse(response.body)['url']).to be_present
        expect(JSON.parse(response.body)['duration']).to be_present
        expect(JSON.parse(response.body)['id']['$oid']).to eq(video.id.to_s)

      end
    end

  end

  context "get all videos" do
    before do
      Sidekiq::Testing.inline!
      allow_any_instance_of(Video).to receive(:process_video).and_return(true)
    end

    def api_call params
      get "/api/v1/video_list", params: params
    end

    let!(:user) { create :user }
    let!(:video) { create :video, user: user }
    let(:url) { "some/url" }
    let(:params) { { token: user.token } }

    it_behaves_like '200'
    it_behaves_like 'json result'

    it 'returns the list of given user videos' do
      allow_any_instance_of(Video).to receive(:url).and_return(url)
      api_call params

      expect(JSON.parse(response.body).first['file_processing']).to be_present
      expect(JSON.parse(response.body).first['url']).to be_present
      expect(JSON.parse(response.body).first['url']).to eq(url)
      expect(JSON.parse(response.body).first['user_id']['$oid']).to eq(user.id.to_s)
      expect(JSON.parse(response.body).first['id']['$oid']).to eq(video.id.to_s)
    end
  end
end



