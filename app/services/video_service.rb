module VideoService

  def self.build_new_video file, user, start_time, end_time
    video = Video.new
    video.file = file
    video.user = user
    video.start_time = start_time
    video.end_time = end_time
    video.duration = end_time.to_i - start_time.to_i
    video
  end
end

