json.array!(@periods) do |period|
  json.extract! period, :id, :ano_periodo, :estatus
  json.url period_url(period, format: :json)
end
