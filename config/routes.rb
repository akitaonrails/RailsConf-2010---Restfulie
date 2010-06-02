ActionController::Routing::Routes.draw do |map|
  map.resources :apps, :collection => { 
    :list_new => :get,
    :list_approved => :get,
    :list_declined => :get 
  }, :member => {
    :evaluate => :post,
    :approve => :post,
    :decline => :post
  }
  map.root :controller => "apps"
end
