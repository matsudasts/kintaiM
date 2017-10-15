Rails.application.routes.draw do
  root to: "kintais#new"

  resources :kintais do
    collection do
      get 'kintai_lists/:kintai_date', to: 'kintais#kintai_lists'
      get 'get_kintai', to: 'kintais#get_kintai'
      get 'exists_kintai', to: 'kintais#exists_kintai'
    end
  end
end
