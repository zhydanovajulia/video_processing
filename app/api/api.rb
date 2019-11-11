class API < Grape::API
  prefix 'api'
  mount Subscribe::API
end
