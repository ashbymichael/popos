Rails.application.routes.draw do
  root 'popos#welcome'

  get  '/popos/upload' => 'popos#upload'
  post '/import'       => 'popos#import'
  post '/search'       => 'popos#search'
  get  '/index'        => 'popos#index'

  get '/markers' => 'popos#map_markers'
end
