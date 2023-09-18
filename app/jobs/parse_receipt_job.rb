class ParseReceiptJob < ApplicationJob
  queue_as :default

  def perform(bill)
    # require 'open-uri'
    url = Cloudinary::Utils.cloudinary_url("#{ENV["RAILS_ENV"]}/#{bill.photo.key}", quality: "auto:low")

    # result = URI.open("https://api.ocr.space/parse/imageurl?apikey=K88423119288957&url=#{url}").read
    # json_result = JSON.parse(result)

    result = ExtractTextFromReceipt.(url:)
    bill.update(receipt_data: result)
  end
end
