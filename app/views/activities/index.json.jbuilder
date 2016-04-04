json.array!(@activities) do |activity|
  json.extract! activity, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url activity_url(activity, format: :json)
end
