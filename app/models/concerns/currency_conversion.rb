module CurrencyConversion
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def currency_attr(attribute_name)
      define_method("#{attribute_name}_in_dollars") do
        (send(attribute_name).to_f / 100) if send(attribute_name).present?
      end

      define_method("#{attribute_name}_in_dollars=") do |dollars|
        send("#{attribute_name}=", (dollars.to_f * 100).to_i) if dollars.present?
      end
    end
  end
end
