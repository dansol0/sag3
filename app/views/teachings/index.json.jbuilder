json.array!(@teachings) do |teaching|
  json.extract! teaching, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url teaching_url(teaching, format: :json)
end
