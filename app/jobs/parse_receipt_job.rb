class ParseReceiptJob < ApplicationJob
  queue_as :default

  def perform(bill)
    require 'open-uri'
    url = Cloudinary::Utils.cloudinary_url(bill.photo.key)

    result = URI.open("https://api.ocr.space/parse/imageurl?apikey=K88423119288957&url=#{url}").read
    json_result = JSON.parse(result)

    puts json_result
  end
end
