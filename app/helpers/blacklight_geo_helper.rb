# Helper methods used for Blacklight Geo
module BlacklightGeoHelper
  # @param [String] id the html id
  # @param [Hash] tag_options options to put on the tag
  def blacklight_geo_tag id, tag_options = {}, &block
    default_data = {
      maxzoom: blacklight_config.view.geo.maxzoom,
      tileurl: blacklight_config.view.geo.tileurl,
      type: blacklight_config.view.geo.type,
      mapattribution: blacklight_config.view.geo.mapattribution
    }

    options = {id: id, data: default_data}.deep_merge(tag_options)
    if block_given?
      content_tag(:div, options, &block)
    else
      tag(:div, options)
    end
  end

  def serialize_geojson
    export = BlacklightGeo::GeojsonExport.new(controller,
                                               @response.docs)
    export.to_geojson
  end
end
