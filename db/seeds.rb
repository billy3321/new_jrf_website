# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


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

rtepath = Rails.root.join('db', 'rte.json')

File.readlines(rtepath).each do |line|                                                                                                                        ····················
  article_data = JSON.parse(line)
  article = Article.new
  article.id = article_data[0]
  article.title = article_data[1]
  article.content = article_data[2]
  article.published_at = Date.parse(article_data[3])
  article.created_at = Date.parse(article_data[3])
  unless article_data[4].empty?
    article.category_id = Category.where(name: article_data[4]).first.id
  end
  article.author = article_data[5]
  unless article_data[6].empty?
    article.catalog_id = Catalog.where(name: article_data[6]).first.id
  end
  article.image = article_data[7]
  article.description = article_data[8]
  article.save
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end