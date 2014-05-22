require 'spec_helper'

describe "BlacklightGeo::Geometry::BoundingBox" do

  let(:bbox) { BlacklightGeo::Geometry::BoundingBox.from_lon_lat_string('-100 -50 100 50') }
  let(:bbox_california) { BlacklightGeo::Geometry::BoundingBox.from_lon_lat_string('-124.4096196 32.5342321 -114.131211 42.0095169') }
  let(:bbox_dateline) {BlacklightGeo::Geometry::BoundingBox.from_lon_lat_string('165 30 -172 -20') }

  it "should instantiate Geometry::BoundingBox" do
    expect(bbox.class).to eq(::BlacklightGeo::Geometry::BoundingBox)
  end

  it "should return center of simple bounding box" do
    expect(bbox.find_center).to eq([0.0, 0.0])
  end

  it "should return center of California bounding box" do
    expect(bbox_california.find_center).to eq([-119.2704153, 37.271874499999996])
  end

  it "should return correct dateline bounding box" do
    expect(bbox_dateline.find_center).to eq([-183.5, 5])
  end
end
