Rails.application.routes.draw do
  root to: "kintais#new"
  resources :kintais
  get "kintais/show/:kintai_date" => "kintais#show"
end
