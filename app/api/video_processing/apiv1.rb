class VideoProcessing::APIv1 < Grape::API
  version 'v1', using: :path

  format :json
  before do
    @current_user = current_user
  end

  desc 'Video provessing'
  namespace :create_video do
    desc 'Upload new video with time frame'
    params do
      requires :token, :file, :start_time, :end_time
    end

    post do
      video = VideoService.build_new_video params[:file], @current_user, params[:start_time], params[:end_time]
      if video.save
        status 200
        { url: video.url, duration: video.duration, id: video.id }
      end
    end
  end

  namespace :retry_processing_video do
    desc 'Retry to process video'

    params do
      requires :token, :video_id
    end

    put do
      video = find_video
      if video
        video.schedule_processing_video
        status 200
        { url: video.url, duration: video.duration, id: video.id }
      end
    end
  end

  namespace :video_list do
    desc 'Get list of all videos'

    params do
      requires :token
    end

    get do
      status 200
      present @current_user.videos, with: API::Entities::VideoEntity
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

    def find_video
      begin
        @current_user.videos.find params[:video_id]
      rescue Mongoid::Errors::DocumentNotFound
        error!({ 'error_msg' => 'video not found' }, 401)
      end
    end

  end
end
