module ApplicationHelper

  def default_meta_tags
    {
      separator: "&mdash;".html_safe,
      site: '財團法人民間司法改革基金會',
      reverse: true,
      description: ' ',
      og: {
        title: '財團法人民間司法改革基金會',
        description: ' ',
        type: 'website',
        image: "",
        site_name: '財團法人民間司法改革基金會'
      }
    }
  end
end
