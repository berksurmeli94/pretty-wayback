require "clockwork"
require "./config/boot"
require "./config/environment"

module Clockwork
  every(1.day, "scraper_worker.perform") do
    # return unless Rails.env.production?
    ScraperWorker.perform_async
  end
end
