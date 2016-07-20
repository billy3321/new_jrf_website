require "rails_helper"

describe Article do
  it "#factory_creat_press_success" do
    expect {
      FactoryGirl.create :press_article
    }.to change { Article.count }.by(1)
  end

  it "#factory_creat_activity_success" do
    expect {
      FactoryGirl.create :activity_article
    }.to change { Article.count }.by(1)
  end

  it "#factory_creat_comment_success" do
    expect {
      FactoryGirl.create :comment_article
    }.to change { Article.count }.by(1)
  end

  it "published work" do
    article1 = FactoryGirl.create(:press_article)
    article2 = FactoryGirl.create(:press_article, published: false)
    article3 = FactoryGirl.create(:press_article, published_at: 1.day.from_now)
    expect(Article.published).to eq([article3, article1])
  end

  it "presses, activities, comments work" do
    article1 = FactoryGirl.create(:press_article, published_at: 1.day.ago)
    article2 = FactoryGirl.create(:press_article, published_at: 2.days.ago)
    article3 = FactoryGirl.create(:activity_article, published_at: 3.days.ago)
    article4 = FactoryGirl.create(:activity_article, published_at: 4.days.ago)
    article5 = FactoryGirl.create(:comment_article, published_at: 5.days.ago)
    article6 = FactoryGirl.create(:comment_article, published_at: 6.days.ago)
    article7 = FactoryGirl.create(:epaper_article, published_at: 7.days.ago)
    article8 = FactoryGirl.create(:epaper_article, published_at: 8.days.ago)
    article9 = FactoryGirl.create(:book_article, published_at: 9.days.ago)
    article10 = FactoryGirl.create(:book_article, published_at: 10.days.ago)
    expect(Article.presses).to eq([article1, article2])
    expect(Article.activities).to eq([article3, article4])
    expect(Article.comments).to eq([article5, article6])
    expect(Article.epapers).to eq([article7, article8])
    expect(Article.books).to eq([article9, article10])
  end

  it "#youtube_update_work" do
    article = FactoryGirl.build(:press_article)
    article.youtube_url = 'https://www.youtube.com/watch?v=Gh1zJVwHhjw'
    article.update_youtube_values
    expect(article.youtube_id).to eq("Gh1zJVwHhjw")
  end
end
