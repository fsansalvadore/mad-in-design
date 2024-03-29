Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'pages#home'

  namespace :admin do
    resources :workshops do
      resources :workshop_teams do
        resources :team_outcomes
      end
    end
  end
  # get 'home' => 'pages#home'
  #workshops controller
  get '/workshops'                                                => 'workshops#index'
  get '/workshops/:year/t/:slug'                                  => 'workshops#show', as: 'team_workshop'
  get '/workshops/:year/t/:slug/teams/:title'                      => 'workshops#team_workshop_team', as: 'team_workshop_team'
  # get '/workshops/:year/t/:slug/teams/:title/giornate/:giornata'   => 'workshops#team_workshop_giornata', as: 'team_workshop_day'
  # get '/workshops/2020/t/prendersi-cura'                          => 'workshops#prendersi_cura'
  # get '/workshops/2020/t/prendersi-cura/team-1'                   => 'workshops#team_1'
  # get '/workshops/2020/t/prendersi-cura/team-1-b'                 => 'workshops#team_1_b'
  # get '/workshops/2020/t/prendersi-cura/team-1/giornate/1'        => 'workshops#team_1_giornata_1'
  get '/workshops/:year/n/:slug'                                  => 'workshops#show', as: 'workshop'

  #projects controller
  get '/projects'                            => 'projects#index'
  get '/projects/:slug'                      => 'projects#show', as: 'project'

  #people controller
  get '/people'                              => 'people#index'

  #contacts controller
  get  '/contacts',      to: 'contacts#index'
  post '/contacts',      to: 'contacts#create'
  get  '/contacts/confirmation',      to: 'contacts#thank_you'

  #pages controller
  get '/about'                               => 'pages#about'
  get '/privacy-cookie-policy'               => 'pages#privacy'

  # Error pages
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unacceptable'
  get '/500', to: 'errors#internal_error'
end
