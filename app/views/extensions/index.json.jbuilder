json.array!(@extensions) do |extension|
  json.extract! extension, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url extension_url(extension, format: :json)
end
