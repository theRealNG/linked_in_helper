require 'csv'

class LinkedInScrapper
  def initialize(html_string)
    @nokogiri_page = Nokogiri::HTML(html_string)
  end

  def extract_profile_details
    search_results = @nokogiri_page.css('li.search-results__result-item')

    csv_content = []
    CSV.generate(headers: true) do |csv|
      csv << ['Name', 'Position', 'Company Name']
      search_results.each do |result|
        profile = result.css('dt.result-lockup__name a.ember-view')
        profile_name = profile.text.strip
        profile_link = profile.attribute('href').value

        position = result.css('div.result-lockup__entity dl dd')[1].text.split('at').first.strip
        company = result.css('span.result-lockup__position-company a.ember-view')
        company_name = company.css('span').first.text.strip

        csv << [profile_name, position, company_name]
      end
    end
  end
end
