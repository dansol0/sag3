json.array!(@subjects) do |subject|
  json.extract! subject, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url subject_url(subject, format: :json)
end
