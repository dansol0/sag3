json.array!(@proyects) do |proyect|
  json.extract! proyect, :id, :titulo, :estatus, :ente_financista, :integrantes, :monto, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url proyect_url(proyect, format: :json)
end
