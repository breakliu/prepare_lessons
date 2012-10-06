PrepareLessons::Application.routes.draw do
  
  resources :groups

  resources :group_study_plans
  get '/show_gsps_personal/:id/' => "group_study_plans#show_gsps_personal", :as => 'show_gsps_personal'
  get '/group_study_plan_list/' => "group_study_plans#group_study_plan_list", :as => 'group_study_plan_list'
  get '/group_study_plan_search/' => "group_study_plans#group_study_plan_search", :as => "group_study_plan_search"
  post '/group_study_plan_search/' => "group_study_plans#group_study_plan_search", :as => "group_study_plan_search"

  resources :group_research_work_plans
  get '/show_grwps_personal/:id/' => "group_research_work_plans#show_grwps_personal", :as => 'show_grwps_personal'
  get '/group_research_work_plan_list/' => "group_research_work_plans#group_research_work_plan_list", :as => 'group_research_work_plan_list'
  get '/group_research_work_plan_search/' => "group_research_work_plans#group_research_work_plan_search", :as => "group_research_work_plan_search"
  post '/group_research_work_plan_search/' => "group_research_work_plans#group_research_work_plan_search", :as => "group_research_work_plan_search"

  resources :summarizes
  get '/show_summarizes_personal/:id/' => "summarizes#show_summarizes_personal", :as => 'show_summarizes_personal'
  get '/summarize_list/' => "summarizes#summarize_list", :as => 'summarize_list'
  get '/summarize_search/' => "summarizes#summarize_search", :as => "summarize_search"
  post '/summarize_search/' => "summarizes#summarize_search", :as => "summarize_search"

  resources :plans
  get '/show_plans_personal/:id/' => "plans#show_plans_personal", :as => 'show_plans_personal'
  get '/plan_list/' => "plans#plan_list", :as => 'plan_list'
  get '/plan_search/' => "plans#plan_search", :as => "plan_search"
  post '/plan_search/' => "plans#plan_search", :as => "plan_search"

  resources :terms

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  
  resources :users
  resources :sessions
  
  get "sessions/new"

  get "users/new"

  resources :lesson_hours

  resources :lessons
  
  get '/show_lesson/:id/(:flag)/(:is_pdf)' => "lessons#show_lesson", :as => 'show_lesson'
  get '/myhome/' => "lessons#myhome", :as => 'myhome'

  get '/course/:course_id' => "lessons#course", :as  => 'course'
  post '/search_lesson/' => "lessons#search_lesson", :as => "search_lesson"

  get '/advanced_search/' => "lessons#advanced_search", :as => "advanced_search"
  post '/advanced_search/' => "lessons#advanced_search", :as => "advanced_search"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'lessons#index2'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
