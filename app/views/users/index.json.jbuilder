json.array!(@users) do |user|
  json.extract! user, :id, :cedula, :nombre1, :nombre2, :apellido1, :apellido2, :email, :direccion, :tlf, :rol, :password, :dedicacion, :cargo, :area, :categoria_actual, :anos_serv, :adscrito, :fecha_ult_ascenso, :grado_academico
  json.url user_url(user, format: :json)
end
