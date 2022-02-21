Rails.application.routes.draw do
  resources :enrollments
  resources :courses
  root 'home#index'
  get 'error', to: "home#error"
  post "courses/delete_enrollment" => "courses#delete_enrollment"
  post "courses/delete_course" => "courses#delete_course"
  get 'enrollments/enrollmentrequest' => 'enrollments#enrollmentrequest'
  post 'enrollments/enrollmentrequest' => 'enrollments#enrollmentrequest'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'signupinstructor', to: 'users#newInstructor', as: 'signupinstructor'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get "*path", to: redirect("/error")
end
