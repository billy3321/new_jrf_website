require "spec_helper"

describe "Static pages" do

  describe "Index" do
    it "should have content" do
      visit root_path
      expect(page).to have_content("雜誌文章")
    end
  end

  describe "About" do
    it "should have content" do
      visit "/about"
      expect(page).to have_content("About")
    end
  end

end
