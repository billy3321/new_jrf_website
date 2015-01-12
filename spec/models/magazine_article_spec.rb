require 'spec_helper'

describe MagazineArticle do
  let(:magazine_article) {FactoryGirl.create(:magazine_article)}

  it "#factory_creat_success" do
    expect {
      FactoryGirl.create :magazine_article
    }.to change { MagazineArticle.count }.by(1)
  end
end