base_url = "#{Setting.url.protocol}://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
 
xml.tag! 'urlset', "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
 
  xml.url do
    xml.loc "#{base_url}"
    xml.changefreq "daily"
    xml.priority 1.0
  end
 
  xml.url do
    xml.loc "#{base_url}/donate"
    xml.lastmod Time.now.to_date
    xml.changefreq "monthly"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/about"
    xml.lastmod Time.now.to_date
    xml.changefreq "daily"
    xml.priority 1.0
  end

  xml.url do
    xml.loc "#{base_url}/articles"
    xml.lastmod Time.now.to_date
    xml.changefreq "daily"
    xml.priority 1.0
  end

  @keywords.each do |keyword|
    xml.url do
      xml.loc keyword_url(keyword)
      xml.lastmod Time.now.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end
 
  @articles.each do |article|
    xml.url do
      xml.loc article_url(article)
      xml.lastmod article.updated_at.to_date
      xml.changefreq "monthly"
      xml.priority 0.9
    end
  end
end