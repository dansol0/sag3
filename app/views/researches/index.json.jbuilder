json.array!(@researches) do |research|
  json.extract! research, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url research_url(research, format: :json)
end
