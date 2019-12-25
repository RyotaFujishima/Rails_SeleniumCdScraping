Rails.application.routes.draw do
  root 'home#top'
  get 'home/selen2' => 'home#selen2'
  get 'home/selen' => 'home#selen'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
