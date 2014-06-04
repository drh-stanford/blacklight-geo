# -*- encoding : utf-8 -*-
require 'spec_helper'

describe BlacklightGeoHelper do

  let(:blacklight_config) { Blacklight::Configuration.new }

  def create_response
    raw_response = eval(mock_query_response)
    Blacklight::SolrResponse.new(raw_response, raw_response['params'])
  end

  let(:r) { create_response }

  before :each do
    CatalogController.blacklight_config = Blacklight::Configuration.new
    CatalogController.configure_blacklight do |config|
      config.view.geo.type = 'placename_coord'

      # These fields also need to be added for some reason for the tests to pass
      # Link in list is not being generated correctly if not passed
      config.index.title_field = 'title_display'
    end
    helper.stub(blacklight_config: blacklight_config)
    helper.instance_variable_set(:@response, r)
    @request = ActionDispatch::TestRequest.new
    @catalog = CatalogController.new
    @catalog.request = @request
    helper.instance_variable_set(:@_controller, @catalog)
  end

  describe "#blacklight_geo_tag" do

    context "with default values" do
      subject { helper.blacklight_geo_tag('blacklight-geo') }
      it { should have_selector "div#blacklight-geo" }
      it { should have_selector "div[data-maxzoom='8'][data-tileurl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'][data-mapattribution='Map data &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>']" }
    end

    context "with custom values" do
     subject { helper.blacklight_geo_tag('blacklight-geo', data: {maxzoom: 6, tileurl: 'http://example.com/', mapattribution: 'hello world' }) }
     it { should have_selector "div[data-maxzoom='6'][data-tileurl='http://example.com/'][data-mapattribution='hello world']" }
    end

    context "when a block is provided" do
      subject { helper.blacklight_geo_tag('foo') { content_tag(:span, 'bar') } }
      it { should have_selector('div > span', text: 'bar') }
    end

  end

  describe "serialize_geojson" do
    it "should return geojson of documents" do
      expect(helper.serialize_geojson).to include('{"type":"FeatureCollection","features":[{"type":"Feature","geometry":{"type":"Point"')
    end
  end

  def mock_query_response
    %({"responseHeader"=>{"status"=>0, "QTime"=>14, "params"=>{"q"=>"tibet", "spellcheck.q"=>"tibet", "qt"=>"search", "wt"=>"ruby", "rows"=>"10"}}, "response"=>{"numFound"=>2, "start"=>0, "maxScore"=>0.016135123, "docs"=>[{"published_display"=>["Dharamsala, H.P."], "author_display"=>"Thub-bstan-yar-ÃŠÂ¼phel, Rnam-grwa", "lc_callnum_display"=>["DS785 .T475 2005"], "pub_date"=>["2005"], "format"=>"Book", "material_type_display"=>["a-e, iv, ii, 407 p."], "title_display"=>"Bod gaÃ¡Â¹â€¦s can gyi rgyal rabs mdor bsdus dris lan brgya pa rab gsal Ã…â€ºel gyi me loÃ¡Â¹â€¦ Ã…Âºes bya ba bÃ…Âºugs so", "id"=>"2008308202", "subject_geo_facet"=>["Tibet (China)"], "language_facet"=>["Tibetan"], "placename_coords"=>["Tibet (China)-|-29.646923-|-91.117212"], "place_bbox"=>"78.3955448 26.8548157 99.116241 36.4833345", "score"=>0.016135123}, {"published_display"=>["Dharamsala, Distt. Kangra, H.P."], "pub_date"=>["2007"], "format"=>"Book", "title_display"=>"Ses yon", "material_type_display"=>["xii, 419 p."], "id"=>"2008308478", "subject_geo_facet"=>["China", "Tibet", "India"], "subject_topic_facet"=>["Education and state", "Tibetans", "Tibetan language", "Teaching"], "language_facet"=>["Tibetan"], "placename_coords"=>["China-|-35.86166-|-104.195397", "Tibet-|-29.646923-|-91.117212", "India-|-20.593684-|-78.96288"], "place_bbox"=>"68.162386 6.7535159 97.395555 35.5044752", "score"=>0.0026767207}]}, "facet_counts"=>{"facet_queries"=>{}, "facet_fields"=>{"format"=>["Book", 2], "lc_1letter_facet"=>["D - World History", 1], "lc_alpha_facet"=>["DS", 1], "lc_b4cutter_facet"=>["DS785", 1], "language_facet"=>["Tibetan", 2], "pub_date"=>["2005", 1, "2007", 1], "subject_era_facet"=>[], "subject_geo_facet"=>["China", 1, "India", 1, "Tibet", 1, "Tibet (China)", 1], "subject_topic_facet"=>["Education and state", 1, "Teaching", 1, "Tibetan language", 1, "Tibetans", 1]}, "facet_dates"=>{}, "facet_ranges"=>{}}, "spellcheck"=>{"suggestions"=>["tibet", {"numFound"=>1, "startOffset"=>0, "endOffset"=>5, "origFreq"=>2, "suggestion"=>[{"word"=>"tibetan", "freq"=>6}]}, "correctlySpelled", true]}})
  end

end
