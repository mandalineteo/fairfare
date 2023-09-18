class ParseReceiptJob < ApplicationJob
  queue_as :default

  def perform(bill)
    # require 'open-uri'
    url = Cloudinary::Utils.cloudinary_url("#{ENV["RAILS_ENV"]}/#{bill.photo.key}", quality: "auto:low")
    result = ExtractTextFromReceipt.(url:) # this is the json

    bill.update(receipt_data: result)
  end
end
