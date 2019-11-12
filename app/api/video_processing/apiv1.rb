class VideoProcessing::APIv1 < Grape::API
  version 'v1', using: :path

  format :json

  desc 'Upload video'
  namespace :video_proc do

    post do
      video = Video.new
      video.upload = params[:file]
      if video.save
        { url: video.upload.url }
      end
    end
  end
end
