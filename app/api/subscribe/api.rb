class Subscribe::API < Grape::API
  mount Subscribe::APIv1
end
