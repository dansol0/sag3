json.array!(@trainings) do |training|
  json.extract! training, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url training_url(training, format: :json)
end
