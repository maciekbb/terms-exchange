json.array!(@terms) do |term|
  json.extract! term, :name, :reason, :day, :hour
  json.url term_url(term, format: :json)
end
