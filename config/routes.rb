Rails.application.routes.draw do
  get '/validate' => 'sessions#validate'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
