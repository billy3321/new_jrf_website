module ApplicationHelper

  def display_shorter(str, length, additional = "...")
    length = length * 2
    text = Nokogiri::HTML(str).text
    if text.display_width >= length
      additional_text = Nokogiri::HTML(additional).text
      new_length = length - additional_text.display_width
      short_string = text[0..new_length]
      while short_string.display_width > new_length
        short_string = short_string[0..-2]
      end
      short_string + additional
    else
      text
    end
  end

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
