require "spec_helper"

describe "Article" do

  let(:catalog) { FactoryGirl.create(:catalog) }
  let(:category) { FactoryGirl.create(:category) }
  let(:keyword) { FactoryGirl.create(:keyword) }
  let(:article) { FactoryGirl.create(:article) }
  let(:new_article) do
    {
      title: "new_article_title",
      content: "new_article_content",
      author: "new_article_author",
      published_at: Date.today,
      image: "new_article_image",
      description: "new_article_description",
      category_id: category.id,
      catalog_id: catalog.id,
      keyword_ids: [keyword.id]
    }
  end



  describe "#new" do
    it "success" do
      get "/articles/new"
      expect(response).to be_success
    end
  end

  describe "#edit" do
    it "success" do
      get "/articles/#{article.id}/edit"
      expect(response).to be_success
    end
  end

  describe "#create" do
    it "success" do
      expect {
        post "/articles", :article => new_article
      }.to change { Article.count }.by(1)
      expect(response).to be_redirect
    end
  end

  describe "#update" do
    it "success" do
      article
      update_data = { :title => "new_title" }
      put "/articles/#{article.id}", :article => update_data
      expect(response).to be_redirect
      article.reload
      expect(article.title).to match(update_data[:title])
    end
  end

  describe "#destroy" do
    it "success" do
      article
      expect {
        delete "/articles/#{article.id}"
      }.to change { Article.count }.by(-1)
      expect(response).to be_redirect
    end
  end

end