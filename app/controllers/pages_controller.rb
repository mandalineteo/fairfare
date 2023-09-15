class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    require 'open-uri'

    @bill = Bill.find(61)

    @url = Cloudinary::Utils.cloudinary_url("#{ENV["RAILS_ENV"]}/#{@bill.photo.key}", quality: "auto:low")

    result = URI.open("https://api.ocr.space/parse/imageurl?apikey=K88423119288957&url=#{@url}").read
    return render json: { result: JSON.parse(result), url: result }

    if user_signed_in?
      render 'pages/dashboard'
    else
      render 'pages/home'
    end
  end
end
