object @catalogs
node(:count) { |_| @catalogs_count }
child(:@catalogs) do
  attributes :id, :name
  attributes image_url: :image
  child(:categories) do
    attributes :id, :name
    child(:keywords) do
      attributes :id, :name
    end
  end
end
node(:status) {"success"}
