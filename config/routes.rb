Rails.application.routes.draw do
  root 'popos#welcome'

  get '/popos/upload' => 'popos#upload'
  post '/import' => 'popos#import'
end
