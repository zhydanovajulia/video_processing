class VideoProcessing::API < Grape::API
  mount VideoProcessing::APIv1
end
