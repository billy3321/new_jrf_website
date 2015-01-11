# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include ActionView::Helpers

Catalog.delete_all

catalogs = [
  {id: 1, name: "自訂網頁"},
  {id: 2, name: "最新訊息"},
  {id: 3, name: "司法改革雜誌"},
  {id: 4, name: "英文小組"},
  {id: 5, name: "出版品"}
]

catalogs.each do |c|
  catalog = Catalog.new(c)
  catalog.id = c['id']
  catalog.save
end

Category.delete_all

categories = [
  {id: 1, name: "每週新聞"},
  {id: 2, name: "最新活動"},
  {id: 3, name: "評論"},
  {id: 4, name: "司法新聞"},
  {id: 5, name: "新聞稿"},
  {id: 6, name: "空白"},
  {id: 7, name: "快筆文章"}
]

categories.each do |c|
  category = Category.new(c)
  category.id = c['id']
  category.save
end

Article.delete_all

rtepath = Rails.root.join('db', 'data', 'rte.json')

if File.file?(rtepath)
  File.readlines(rtepath).each do |line|
    article_data = JSON.parse(line)
    article = Article.new
    article.id = article_data[0]
    article.title = article_data[1]
    article.content = article_data[2]
    if article_data[3].empty?
      article.published_at = Date.today
    else
      article.published_at = Date.parse(article_data[3])
      article.created_at = Date.parse(article_data[3])
    end
    unless article_data[4].empty?
      article.category_id = Category.where(name: article_data[4]).first.try(:id)
    end
    article.author = article_data[5]
    unless article_data[6].empty?
      article.catalog_id = Catalog.where(name: article_data[6]).first.try(:id)
    end
    article.image = article_data[7]
    article.description = article_data[8]
    article.published = true
    article.save
  end
end

Magazine.delete_all
Column.delete_all
MagazineArticle.delete_all

magazinepath = Rails.root.join('db', 'data', 'magazines.json')
#["標題","作者","卷","期","日期","專欄","全文","註釋"]
if File.file?(magazinepath)
  File.readlines(magazinepath).each do |line|
    magazine_article_data = JSON.parse(line)
    magazine_article = MagazineArticle.new
    magazine = Magazine.where(issue: magazine_article_data[3]).first
    unless magazine
      magazine = Magazine.new
      magazine.volumn = magazine_article_data[2]
      magazine.issue = magazine_article_data[3]
      magazine.id = magazine_article_data[3]
      published_at = Date.parse(magazine_article_data[4])
      magazine.published_at = published_at
      magazine.name = "司改雜誌第#{magazine_article_data[3]}期"
      magazine.created_at = published_at
      magazine.save
    end
    magazine_article.magazine = magazine
    column = Column.where(name: magazine_article_data[5]).first
    unless column
      column = Column.new
      column.name = magazine_article_data[5]
      column.save
    end
    magazine_article.column = column
    magazine_article.title = magazine_article_data[0].gsub(/\n/, '')
    magazine_article.author = magazine_article_data[1]
    magazine_article.content = simple_format(magazine_article_data[6]).gsub(/\n/, '')
    magazine_article.comment = simple_format(magazine_article_data[7]).gsub(/\n/, '')
    magazine_article.save
  end
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end