atom_feed ({language: 'zh-TW', url: root_url}) do |feed|
  feed.title "民間司法改革基金會"
  feed.updated @articles.maximum(:published_at)

  @articles.each do |article|
    feed.entry article, {published: article.published_at, updated: article.updated_at} do |entry|
      entry.title article.title
      entry.content article.content, type: 'html'
      entry.author do |author|
        author.name article.author
      end
      entry.url article_url(article)
      entry.summary article.description
    end
  end
end