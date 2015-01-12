require "spec_helper"

describe "Catalog" do


  let(:catalog) { FactoryGirl.create(:catalog) }
  let(:new_catalog) do
    {
      :name => "new_catalog_name",
    }
  end

  describe "#new" do
    it "success" do
      get "/catalogs/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/catalogs/#{catalog.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/catalogs", :catalog => new_catalog
      }.to change { Catalog.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      catalog
      update_data = { :name => "new_name" }
      put "/catalogs/#{catalog.id}", :catalog => update_data
      expect(response).to be_redirect
      catalog.reload
      expect(catalog.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      catalog
      expect {
        delete "/catalogs/#{catalog.id}"
      }.to change { Catalog.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end