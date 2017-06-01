Rails.application.routes.draw do
  root to: "kintais#new"

  resources :kintais

  
end
