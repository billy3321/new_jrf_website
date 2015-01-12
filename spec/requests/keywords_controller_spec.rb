require "spec_helper"

describe "Keyword" do


  let(:keyword) { FactoryGirl.create(:keyword) }
  let(:new_keyword) do
    {
      :name => "new_keyword_name",
    }
  end

  describe "#new" do
    it "success" do
      get "/keywords/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/keywords/#{keyword.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/keywords", :keyword => new_keyword
      }.to change { Keyword.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      keyword
      update_data = { :name => "new_name" }
      put "/keywords/#{keyword.id}", :keyword => update_data
      expect(response).to be_redirect
      keyword.reload
      expect(keyword.name).to match(update_data[:name])
    end
  end

  describe "#destroy" do
    it "success" do
      keyword
      expect {
        delete "/keywords/#{keyword.id}"
      }.to change { Keyword.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end