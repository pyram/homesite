Rails.application.routes.draw do
  root "pages#index"
  get 'pages/scrape_pracuj_pl'
end
