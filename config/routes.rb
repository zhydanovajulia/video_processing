require 'sidekiq/web'

Rails.application.routes.draw do

  mount API => '/'

  mount Sidekiq::Web => '/sidekiq'
end
