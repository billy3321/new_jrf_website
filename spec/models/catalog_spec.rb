require 'spec_helper'

describe Catalog do
  let(:catalog) {FactoryGirl.create(:catalog)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :catalog
    }.to change { Catalog.count }.by(1)
  end
end