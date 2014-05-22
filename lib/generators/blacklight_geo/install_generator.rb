require 'rails/generators'

module BlacklightGeo
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    desc "Install blacklight-geo"

    def assets
      copy_file "blacklight_geo.css.scss", "app/assets/stylesheets/blacklight_geo.css.scss"

      unless IO.read("app/assets/javascripts/application.js").include?('blacklight-geo')
        marker = IO.read("app/assets/javascripts/application.js").include?('turbolinks') ?
          '//= require turbolinks' : "//= require jquery_ujs"
        insert_into_file "app/assets/javascripts/application.js", :after => marker do
          %q{
//
// Required by blacklight-geo
//= require blacklight-geo}
        end
      end
    end
  end
end