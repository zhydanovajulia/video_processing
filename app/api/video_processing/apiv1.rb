class VideoProcessing::APIv1 < Grape::API
  version 'v1', using: :path

  format :json
  before do
    current_user
  end

  desc 'Upload video'
  namespace :create_video do

    params do
      requires :token, :file
    end

    post do
      video = VideoService.create_new_video params[:file], current_user
      if video.save
        status 200
        { url: video.url }
      end
    end
  end

  helpers do
    def current_user
      begin
        User.find_by(token: params[:token])
      rescue Mongoid::Errors::DocumentNotFound
        error!({ 'error_msg' => 'access denied' }, 401)
      end
    end
  end
end
