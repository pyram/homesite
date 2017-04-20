class PagesController < ApplicationController
  before_filter :require_pracuj_pl_jobs
  skip_before_filter :only => [:index]

  def index
    #  scrape_pracuj_pl
  end

  def scrape_pracuj_pl
    require 'open-uri'
  # @search_term = 'Neubloc'
  # @search_term = 'Neubloc' + ";kw"
  @search_term = 'ma%C5%82opolskie;r,6/Getin%20Noble%20Bank%20S.A.;en'
  url_prefix = 'https://pracuj.pl'
  if request.parameters['st']!=NIL
     @search_term = request.parameters['st'] + ";kw"
  end
    doc = Nokogiri::HTML(open("https://www.pracuj.pl/praca/" + @search_term))

    # entries = doc.xpath("//span[@itemprop='title']/..")
    entries = doc.xpath('//li[@itemtype=\'http://schema.org/JobPosting\']')
    @entriesArray = []
    entries.each do |entry|
        # location = ''
        locationsArray = []
        entry.xpath('.//a[@itemprop="addressRegion"]').each do |loc|
          locationsArray << Entry.new(loc.text, url_prefix + loc['href'], [])
        end
        title = entry.xpath('.//*[@itemprop="title"]').text
       link = url_prefix + entry.xpath(".//a[@class='o-list_item_link_name']")[0]['href']
       @entriesArray << Entry.new(title, link, locationsArray)
     end
    #  render template: 'pages/scrape_pracuj_pl'
  end

    private
      def require_pracuj_pl_jobs
        scrape_pracuj_pl
      end
end
