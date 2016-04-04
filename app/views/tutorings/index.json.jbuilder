json.array!(@tutorings) do |tutoring|
  json.extract! tutoring, :id, :tipo, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url tutoring_url(tutoring, format: :json)
end
