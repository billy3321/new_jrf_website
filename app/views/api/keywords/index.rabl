object @keywords
node(:count) { |_| @keywords_count }
child(:@keywords) do
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
end
node(:status) {"success"}
