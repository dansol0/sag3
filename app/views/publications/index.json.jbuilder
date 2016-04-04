json.array!(@publications) do |publication|
  json.extract! publication, :id, :titulo, :revista_editorial, :arbitr_no_arbitr, :descripcion, :horas, :fecha_i, :fecha_f, :ano_periodo, :user_id
  json.url publication_url(publication, format: :json)
end
