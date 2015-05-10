require "rails_helper"

describe "Article" do

  let(:press_article) { FactoryGirl.create(:press_article) }
  let(:activity_article) { FactoryGirl.create(:activity_article) }
  let(:issue_article) { FactoryGirl.create(:issue_article) }

  describe "#presses" do
    it "success" do
      2.times { FactoryGirl.create(:press_article) }
      get "/articles/presses"
      expect(response).to be_success
    end
  end

  describe "#press_show" do
    it "success" do
      get "/articles/#{press_article.id}"
      expect(response).to be_success
    end
  end

  describe "#activities" do
    it "success" do
      2.times { FactoryGirl.create(:activity_article) }
      get "/articles/activities"
      expect(response).to be_success
    end
  end

  describe "#activity_show" do
    it "success" do
      get "/articles/#{activity_article.id}"
      expect(response).to be_success
    end
  end

  describe "#issues" do
    it "success" do
      2.times { FactoryGirl.create(:issue_article) }
      get "/articles/issues"
      expect(response).to be_success
    end
  end

  describe "#issue_show" do
    it "success" do
      get "/articles/#{issue_article.id}"
      expect(response).to be_success
    end
  end
end