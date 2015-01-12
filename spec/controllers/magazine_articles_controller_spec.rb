require "spec_helper"

describe "MagazineArticle" do

  let(:column) { FactoryGirl.create(:column) }
  let(:magazine) { FactoryGirl.create(:magazine) }
  let(:magazine_article) { FactoryGirl.create(:magazine_article) }
  let(:new_magazine_article) do
    {
      title: "new_magazine_article_title",
      content: "new_magazine_article_content",
      author: "new_magazine_article_author",
      comment: "new_magazine_article_comment",
      magazine_id: magazine.id,
      column_id: column.id
    }
  end

  describe "#new" do
    it "success" do
      get "/magazine_articles/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/magazine_articles/#{magazine_article.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/magazine_articles", :magazine_article => new_magazine_article
      }.to change { MagazineArticle.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      magazine_article
      update_data = { :name => "new_title" }
      put "/magazine_articles/#{magazine_article.id}", :magazine_article => update_data
      expect(response).to be_redirect
      magazine_article.reload
      expect(magazine_article.title).to match(update_data[:title])
    end
  end

  describe "#destroy" do
    it "success" do
      magazine_article
      expect {
        delete "/magazine_articles/#{magazine_article.id}"
      }.to change { MagazineArticle.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end