require "spec_helper"

describe "Magazine" do


  let(:magazine) { FactoryGirl.create(:magazine) }
  let(:new_magazine) do
    {
      issue: 30,
      volumn: "new_magazine_volumn",
      published_at: Date.today.strftime('%Y-%m-%d'),
      name: "司改雜誌第30期"
    }
  end

  describe "#new" do
    it "success" do
      get "/magazines/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/magazines/#{magazine.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/magazines", :magazine => new_magazine
      }.to change { Magazine.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      magazine
      update_data = { :issue => 50 }
      put "/magazines/#{magazine.id}", :magazine => update_data
      expect(response).to be_redirect
      magazine.reload
      expect(magazine.issue).to eq(update_data[:issue])
    end
  end

  describe "#destroy" do
    it "success" do
      magazine
      expect {
        delete "/magazines/#{magazine.id}"
      }.to change { Magazine.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end