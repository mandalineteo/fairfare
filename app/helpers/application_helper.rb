module ApplicationHelper
  def cents_to_dollars(cents)
    return 0 if cents.nil?

    format("%.2f", cents / 100.00)
  end
end
