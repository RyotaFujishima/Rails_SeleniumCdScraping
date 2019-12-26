Rails.application.routes.draw do
  root 'home#top'
  get 'home/selen2' => 'home#selen2'
  get 'home/selen' => 'home#selen'

  resources :scrapings
  
  resources :imports do
    collection { post :import }
  end
  
end
