# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include ActionView::Helpers

Catalog.delete_all

Category.delete_all

Article.delete_all

rte_path = Rails.root.join('db', 'data', 'rte.json')

if File.file?(rte_path)
  File.readlines(rte_path).each do |line|
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
    article.author = article_data[5]
    article.image = article_data[7]
    article.description = article_data[8]
    article.published = true
    article.save
  end
end

Magazine.delete_all
Column.delete_all
MagazineArticle.delete_all

magazine_path = Rails.root.join('db', 'data', 'magazines.json')
#["標題","作者","卷","期","日期","專欄","全文","註釋"]
if File.file?(magazine_path)
  File.readlines(magazine_path).each do |line|
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

Epaper.delete_all

epaper_path = Rails.root.join('db', 'data', 'epapers.json')

if File.file?(epaper_path)
  File.readlines(epaper_path).each do |line|
    epaper_data = JSON.parse(line)
    epaper = Epaper.new
    epaper.id = epaper_data[0]
    epaper.title = epaper_data[3]
    epaper.filename = epaper_data[2]
    e_path = Rails.root.join('db', 'epapers', epaper_data[2])
    if File.file?(e_path)
      content = File.read(e_path)
      encoding = CharlockHolmes::EncodingDetector.detect(content)[:encoding]
      unless encoding == "UTF-8"
        #ic = Iconv.new('UTF-8//IGNORE', encoding)
        #content = ic.iconv(content)
        # Another way
        content = CharlockHolmes::Converter.convert(content, encoding, 'UTF-8')
      end
      epaper.content = content
    else
      epaper.content = ''
    end
    epaper.published_at = Date.parse(epaper_data[1])
    epaper.created_at = epaper.published_at
    epaper.save
  end
end

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end