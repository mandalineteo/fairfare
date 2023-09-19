# if @payer.persisted?
#   json.form render(partial: "payers/form", formats: :html, locals: {payer: Payer.new})
#   json.inserted_item render(partial: "payers/payer", formats: :html, locals: {payer: @payer})
# else
#   json.form render(partial: "payers/form", formats: :html, locals: {payer: @payer})
# end
