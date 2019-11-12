class Video
  include Mongoid::Document

  field :duration, type: :integer

  mount_uploader :upload, VideoUploader, mount_on: :upload_filename

  belongs_to :user

  def url
    upload.url
  end
end
