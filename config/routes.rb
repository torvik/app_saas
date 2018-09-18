Rails.application.routes.draw do

#resources :standups
devise_for :users, controllers: { registrations: "registrations" }
resource :accounts

get 't/new', to: 'teams#new'
get 't/:id/edit', to: 'teams#edit'
get 't/:id/s', to: 'teams#standups', as: 'team_standups'
get 't/:id/s/(:date)', to: 'teams#standups', as: 'team_standups_by_date'
get 't/:id/(:date)', to: 'teams#show'
resources :teams, path: 't'

get 's/new/(:date)', to: 'standups#new', as: 'new_standup'
get 's/edit/(:date)', to: 'standups#edit', as: 'edit_standup'
resources :standups, path: 's', except: [:new, :edit]

get 'user/me', to: 'users#me', as: 'my_settings'
patch 'users/update_me', to: 'users#update_me', as: 'update_my_settings'
get 'user/password', to: 'users#password', as: 'my_password'
patch 'user/update_password',to:'users#update_password',as:'my_update_password'

scope 'account', as: 'account' do
  resources :users
end

get 'activity/mine'
get 'activity/feed'

get 'dates/:date', to: 'dates#update', as: 'update_date'

root to: 'activity#mine'

end
