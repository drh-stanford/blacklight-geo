require 'rails/generators'

module BlacklightGeo
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    desc "Install Blacklight-Geo"

    def assets
      copy_file "assets/stylesheets/blacklight_geo.css.scss", "app/assets/stylesheets/blacklight_geo.css.scss"
      %w{
        geologo.png
        src_berkeley.png
        src_cambridge.png
        src_harvard.png
        src_maryland.png
        src_massgis.png
        src_mit.png
        src_princeton.png
        src_stanford.png
        src_tufts.png
        src_un.png
        type_arc.png
        type_dot.png
        type_map.png
        type_polygon.png
        type_raster.png
      }.each do |k|
        copy_file "assets/images/#{k}", "app/assets/images/#{k}"
      end

      unless IO.read("app/assets/javascripts/application.js").include?('blacklight-geo')
        marker = IO.read("app/assets/javascripts/application.js").include?('turbolinks') ?
          '//= require turbolinks' : "//= require jquery_ujs"
        insert_into_file "app/assets/javascripts/application.js", :after => marker do
          %q{
//
// Required by Blacklight-Geo
//= require blacklight-geo}
        end
      end
      
      %w{analytics.js.coffee download.js.coffee home.js mapResult.js mapView.js}.each do |k|
        copy_file "assets/javascripts/#{k}", "app/assets/javascripts/blacklight_geo/#{k}"
      end
    end
    
    def create_controllers
      %w{catalog download wms}.each do |k|
        copy_file "controllers/#{k}_controller.rb", "app/controllers/#{k}_controller.rb"
      end
    end 
    
    def inject_routes
      # route 'devise_for :users'
      route 'constraints(:id => /[0-9A-Za-z\-\.\:\_\/]+/) do
               blacklight_for :catalog
               resources :bookmarks
             end'
      route 'get \'/catalog/facet/:id\' => \'catalog#facet\''
      route 'root :to => "catalog#index"'
      route 'post "wms/handle"'
      route 'post "download/kml"'
      route 'post "download/shapefile"'
      route 'get "download/file"'
    end 
    
    def models
      # XXX
    end
    
    def views
      %w{catalog download wms}.each do |k|
        directory "views/#{k}", "app/views/#{k}"
      end
    end
  
    def helpers
      %w{application blacklight download wms}.each do |k|
        copy_file "helpers/#{k}_helper.rb", "app/helpers/#{k}_helper.rb"
      end
    end
  end
end