module VideoService

  def self.create_new_video file, user
    video = Video.new
    video.upload = file
    video.user = user
    video
  end
end

