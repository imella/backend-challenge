class HeadingsParser
  attr_reader :url, :content

  def initialize(url)
    @url = url
  end

  def parse
    download_content

    page = Nokogiri::HTML(content.body)
    headings = page.css('h1,h2,h3').flat_map do |element|
      element.children.map(&:text)
    end

    headings.reject(&:blank?)
  end


  private

  def download_content
    @content = HTTParty.get(url)
  end
end
