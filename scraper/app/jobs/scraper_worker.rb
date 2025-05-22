class ScraperWorker
  include Sidekiq::Worker

  sidekiq_options queue: :scraper, retry: false

  def perform
    puts "Scraping started at #{Time.now}"
  end
end
