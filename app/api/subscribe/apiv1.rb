class Subscribe::APIv1 < Grape::API
  version 'v1', using: :path

  format :json

  desc 'Regist user'
    namespace :subscribe do
      desc 'Get token to identify user'

      get do
        user = UserService.subscibe_new_user
        if user.save
          { token: user.token }
        end
      end

  end
end
