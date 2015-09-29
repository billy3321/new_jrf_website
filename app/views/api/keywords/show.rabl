object @keyword
child(:@keyword) do
  attributes :id, :name, :showed
  attributes :title, :description, :content
  attributes image_url: :image
  attributes cover_url: :cover
  child(:category) do
    attributes :id, :name
    child(:catalog) do
      attributes :id, :name
    end
  end
  child(:articles) do
    attributes :id, :title, :author, :content, :kind, :youtube_url, :youtube_id
    attributes :description, :published_at, :created_at, :updated_at
    attributes image_url: :image
    child(:keywords) do
      attributes :id, :name
    end
  end
end
node(:status) {"success"}
