require "spec_helper"

describe "Column" do


  let(:column) { FactoryGirl.create(:column) }
  let(:new_column) do
    {
      name: "new_column_name",
    }
  end

  describe "#new" do
    it "success" do
      get "/columns/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/columns/#{column.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/columns", column: new_column
      }.to change { Column.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      column
      update_data = { name: "new_name" }
      put "/columns/#{column.id}", column: update_data
      expect(response).to be_redirect
      column.reload
      expect(column.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      column
      expect {
        delete "/columns/#{column.id}"
      }.to change { Column.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end