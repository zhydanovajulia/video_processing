module Entities
  class VideoEntity <  Grape::Entity
    expose :duration, documentation: { type: Integer, desc: "Video duration." }
    expose :url, documentation: { type: String, desc: "Video url." }
    expose :user_id, documentation: { type: Integer, desc: "Author ID." }
    expose :file_processing, documentation: { type: Integer, desc: "Shows status of video procesing" }
    expose :id, documentation: { type: Integer, desc: "Video ID." }
  end
end
