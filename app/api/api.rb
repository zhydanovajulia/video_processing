class API < Grape::API
  prefix 'api'
  mount Subscribe::API
  mount VideoProcessing::API
end
