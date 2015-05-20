require "rails_helper"

describe "Article" do

  let(:press_article) { FactoryGirl.create(:press_article) }
  let(:activity_article) { FactoryGirl.create(:activity_article) }
  let(:comment_article) { FactoryGirl.create(:comment_article) }

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

  describe "#comments" do
    it "success" do
      2.times { FactoryGirl.create(:comment_article) }
      get "/articles/comments"
      expect(response).to be_success
    end
  end

  describe "#comment_show" do
    it "success" do
      get "/articles/#{comment_article.id}"
      expect(response).to be_success
    end
  end
end