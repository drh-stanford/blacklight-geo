# Blacklight::Geo

GeoBlacklight started at Stanford and its goal is to provide a
world-class discovery platform for geospatial (GIS) holdings. It
is an open collaborative project aiming to build off of the successes
of the Blacklight Solr-powered discovery interface and the
multi-institutional OpenGeoportal federated metadata sharing
communities. We are currently in a collaborative design phase and
we're actively looking for community input and development partners.
More coming soon!

## Installation

Install [Blacklight 5.1.0](https://github.com/projectblacklight/blacklight/wiki/Quickstart)

Add this to your application's `Gemfile`:

    gem 'blacklight', "5.1.0"
    gem 'blacklight-geo', :path => '../blacklight-geo'
    gem 'blacklight_range_limit'
    gem 'font-awesome-sass'
    gem 'leaflet-rails'
    gem 'httparty'

And then execute:

    $ bundle install

Run blacklight-geo generator:

    $ rails generate blacklight_geo:install
    
Edit your Solr configuration to point to a [geoblacklight-schema](http://github.com/sul-dlss/geoblacklight-schema) Solr instance:

    $ vi config/solr.yml

Edit your `config/environments/development.rb` parameters to include:

      config.assets.precompile += %w( blacklight_geo/home.js blacklight_geo/mapResult.js blacklight_geo/mapView.js)

Verify that routes are correct:

    $ vi config/routes.rb
    
Start the application:

    $ rails server

## Features

* Text search with scoring formula
* Facet by institution, year, publisher, data type, access, format
* Facet by place, subject
* Sort by relevance, year, publisher, title, collection
* Results list map view of bounding boxes
* Results list view icons and snippets
* Detail map view for WMS features
* Detail map view feature inspection
* Slugs
* Blacklight bookmarks and history
* WMS/WFS/WCS links

## TODO

* Spatial search
* Spatial relevancy
* MODS display
* Download KML
* Download Shapefile / GeoTIFF
* Clip to map view for download
* Download Metadata (for non-Stanford, MODS for Stanford)
* Facet by language, projection, collection
* Citation and share buttons
* Login for persistent bookmarks and history
* Featured datasets and articles
* FGDC-based conversion of external OGP records
* MODS-based conversion for Stanford records

* blacklight-geo
  * search field is too short
  * Time slider not enabled
  * tool icons busted
  * ...more link busted
  * maps require reloads
  * bounding box mouseovers busted
