json.array!(@coferences) do |coference|
  json.extract! coference, :id, :tipo, :titulo, :evento, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url coference_url(coference, format: :json)
end
