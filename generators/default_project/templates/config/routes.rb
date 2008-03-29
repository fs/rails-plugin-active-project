ActionController::Routing::Routes.draw do |map|

    ## admin part
    map.namespace :admin do |admin|
        admin.root :controller => 'index'
        admin.resource :session
    end
    
    ## public part
    map.root :controller => 'index'
end
