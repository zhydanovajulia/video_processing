class VideoProcessingWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform video_id
    video = Video.find video_id
    video.perform_processing
  end

end
