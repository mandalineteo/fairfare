class ExtractTextFromReceipt < ApplicationService
  def initialize(url:)
    @url = url
  end

  def call
    require 'open-uri'
    require 'uri'
    require 'net/http'
    require 'net/https'
    require 'mime/types'
    require 'tempfile'

    cloudinary_url = @url

    url = URI("https://api.mindee.net/v1/products/mindee/expense_receipts/v5/predict")

    cloudinary_file = URI.open(cloudinary_url)

    temp_file = Tempfile.new(['temp', File.extname(cloudinary_url)], 'tmp')

    temp_file.write(cloudinary_file.read.force_encoding(Encoding::UTF_8))

    temp_file.rewind

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Token #{ENV['RECEIPT_KEY']}"
    request.set_form([['document', File.open(temp_file)]], 'multipart/form-data')

    response = http.request(request)

    temp_file.close
    temp_file.unlink

    JSON.parse(response.read_body)
  end
end
