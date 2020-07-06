Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'pages#temporary'

  namespace :admin do
    resources :workshops do
      resources :workshop_teams do
        resources :team_outcomes
      end
    end
  end
  get 'home' => 'pages#home'
  #workshops controller
  get '/workshops'                                              => 'workshops#index'
  # get '/workshops/:year/s/:slug'                                => 'workshops#special_workshop_index'
  # get '/workshops/:year/s/:slug/teams/:team'                    => 'workshops#special_workshop_team'
  # get '/workshops/:year/s/:slug/teams/:team/giornate/:giornata' => 'workshops#special_workshop_giornata'
  get '/workshops/2020/s/prendersi-cura'                        => 'workshops#prendersi_cura'
  get '/workshops/:year/n/:slug'                                => 'workshops#show', as: 'workshop'

  #projects controller
  get '/projects'                            => 'projects#index'
  get '/projects/:slug'                      => 'projects#show', as: 'project'

  #people controller
  get '/people'                              => 'people#index'

  #pages controller
  get '/about'                               => 'pages#about'
  get '/contatti'                            => 'pages#contacts'
  get '/privacy-cookie-policy'               => 'pages#privacy'

  # Error pages
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
end
