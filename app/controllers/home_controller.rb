require 'linked_in_scrapper'
class HomeController < ApplicationController
  def index
  end

  def extract
    file_content = File.open(params[:result_set_page].tempfile).read
    file_name = params[:result_set_page].original_filename
    scrapper = LinkedInScrapper.new(file_content)

    respond_to do |format|
      format.csv do
        send_data(
          scrapper.extract_profile_details,
          filename: file_name.split('.').first + '.csv'
        )
      end
    end
  end
end
