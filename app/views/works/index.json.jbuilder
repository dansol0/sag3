json.array!(@works) do |work|
  json.extract! work, :id, :tipo, :titulo, :autores, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url work_url(work, format: :json)
end
