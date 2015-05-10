require "rails_helper"

describe "Static pages" do

  describe "#home" do
    it "success" do
      2.times { FactoryGirl.create :keyword }
      2.times { FactoryGirl.create :article }
      get "/"
      expect(response).to be_success
    end
  end

  describe "#about" do
    it "success" do
      FactoryGirl.create :about_article
      get "/about"
      expect(response).to be_success
    end
  end

  describe "#donate" do
    it "success" do
      FactoryGirl.create :donate_article
      get "/donate"
      expect(response).to be_success
    end
  end
end