class Video
  include Mongoid::Document

  field :duration, type: Integer
  field :file_processing, type: Integer, default: -> { 0 }
  field :start_time, type: Integer
  field :end_time, type: Integer

  validates :duration, presence: true
  validates :file_processing, presence: true

  mount_uploader :file, VideoUploader, mount_on: :file_filename

  belongs_to :user

  after_create :schedule_processing_video

  def schedule_processing_video
    self.file_processing = self.class.statuses[:scheduled]
    VideoProcessingWorker.perform_async self.id
  end

  def perform_processing
    self.file_processing = self.class.statuses[:processing]
    #processing video file
    self.file_processing = self.class.statuses[:done]
  rescue Exception => e
    self.file_processing = self.class.statuses[:failed]
  ensure
    self.save!
  end

  def url
    file.url
  end

  def self.statuses
    { scheduled: 0, processing: 1, done: 2, failed: 3 }
  end

end
