class User
  include Mongoid::Document

  field :token, type: String

  has_many :videos

  validates :token, presence: true
end

