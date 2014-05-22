require 'spec_helper'

describe "Map View", js: true do

  describe "using placename coords" do
    before do
      CatalogController.blacklight_config = Blacklight::Configuration.new
      CatalogController.configure_blacklight do |config|
        config.view.geo.type = 'placename_coord'
        config.view.geo.placename_coord_delimiter = '-|-'
        # These fields also need to be added for some reason for the tests to pass
        # Link in list is not being generated correctly if not passed
        config.index.title_field = 'title_display'
      end
    end

    before { visit catalog_index_path :q => 'tibet', :view => 'geo' }

    it "should display geo elements" do
      expect(page).to have_selector("#documents.geo")
      expect(page).to have_selector("#blacklight-geo")
      expect(page).to have_selector("#blacklight-geo-sidebar")
    end

    describe "data attributes" do

      it "maxzoom should be 8" do
        expect(page).to have_selector("#blacklight-geo[data-maxzoom='8']")
      end

      it "type should be placename_coord" do
        expect(page).to have_selector("#blacklight-geo[data-type='placename_coord']")
      end

      it "tileurl should be OSM" do
        expect(page).to have_selector("#blacklight-geo[data-tileurl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png']")
      end

    end

    describe "marker clusters" do

      it "should have marker cluster div" do
        expect(page).to have_selector("div.marker-cluster")
      end

      it "should only have one marker cluster" do
        expect(page).to have_selector('div.marker-cluster', count: 1)
      end

      it "should have 4 markers" do
        expect(find("div.marker-cluster")).to have_content(4)
      end

      it "should display tile layer attribution" do
        expect(find("div.leaflet-control-container")).to have_content('OpenStreetMap contributors, CC-BY-SA')
      end

      describe "Click Marker cluster" do
        before { find("div.marker-cluster").click }

        it "should have three marker clusters" do
          expect(page).to have_selector('div.marker-cluster', count: 3)
        end

        describe "Click low level marker cluster" do
          before { find("div.marker-cluster[title='India']").click }

          it "should show sidebar with content" do
            expect(page).to have_content("es yon")
          end

          describe "Navigate to catalog page" do
            before { click_link("es yon") }

            it "should show page with content" do
              expect(page).to have_content("es yon")
            end
          end
        end
      end
    end
  end

  describe "using bounding box" do
    before do
      CatalogController.blacklight_config = Blacklight::Configuration.new
      CatalogController.configure_blacklight do |config|
        config.view.geo.type = 'bbox'
        config.view.geo.bbox_field = 'place_bbox'
      end
    end

    before { visit catalog_index_path :q => 'korea', :view => 'geo' }

    it "should have 4 markers" do
      expect(find("div.marker-cluster")).to have_content(4)
    end

    it "should display number mapped" do
      expect(page).to have_content('4 mapped')
    end

    describe "click marker cluster" do
      before { find("div.marker-cluster").click }

      it "should split into 2 markers" do
        expect(page).to have_selector('div.marker-cluster', count: 2)
      end
    end
  end
end
