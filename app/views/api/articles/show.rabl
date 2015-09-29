object @article
child(:@article) do
  attributes :id, :title, :author, :content, :kind, :youtube_url, :youtube_id
  attributes :description, :published_at, :created_at, :updated_at
  attributes image_url: :image
  child(:keywords) do
    attributes :id, :name
  end
end
node(:status) {"success"}
