class API < Grape::API
  prefix 'api'

  rescue_from Grape::Exceptions::ValidationErrors do |e|
    rack_response({
      status: e.status,
      error_msg: e.message,
    }.to_json, 400)
  end

  mount Subscribe::API
  mount VideoProcessing::API

end
