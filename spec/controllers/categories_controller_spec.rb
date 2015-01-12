require "spec_helper"

describe "Category" do


  let(:category) { FactoryGirl.create(:category) }
  let(:new_category) do
    {
      :name => "new_category_name",
    }
  end

  describe "#new" do
    it "success" do
      get "/categorys/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/categorys/#{category.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/categorys", :category => new_category
      }.to change { Category.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      category
      update_data = { :name => "new_name" }
      put "/categorys/#{category.id}", :category => update_data
      expect(response).to be_redirect
      category.reload
      expect(category.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      category
      expect {
        delete "/categorys/#{category.id}"
      }.to change { Category.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end