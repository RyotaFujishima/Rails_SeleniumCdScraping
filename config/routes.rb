Rails.application.routes.draw do
  root 'home#top'
  get 'home/selen3' => 'home#selen3'
  get 'home/selen2' => 'home#selen2'
  get 'home/selen' => 'home#selen'

  # スクレイピングデータベース
  get 'scrapings/csv_export/:model_number' => 'scrapings#csv_export'
  get 'scrapings/csv_export' => 'scrapings#csv_export'
  get 'scrapings/:model_number' => 'scrapings#show'
  resources :scrapings
  
  # インポート
  get 'imports/done' => 'imports#done'
  get 'imports/non_done' => 'imports#non_done'
  resources :imports do
    collection { post :import }
  end
  
  
end
