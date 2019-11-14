module VideoService

  def self.build_new_video file, user, start_time, end_time
    video = Video.new
    video.file = file
    video.user = user
    video.start_time = start_time
    video.end_time = end_time
    video.duration = video.end_time - video.end_time
    video
  end
end

