class User
  include Mongoid::Document

  field :token, type: String

end

