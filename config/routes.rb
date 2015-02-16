Rails.application.routes.draw do

  scope "(:locale)", :locale => /#{I18n.available_locales.join("|")}/ do
  root :to => "catalog#index"

  
  blacklight_for :catalog


 # Tags and Bookmarks
    resources :documents, :only => [] do
      resources :tags,                              :except => [:edit, :update]
    end
    resources :tags,                                :only => [:edit, :update, :destroy]
    get   'tags',                                   :to => 'tags#manage',                           :as => 'manage_tags'


  end
end
