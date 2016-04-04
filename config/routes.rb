Rails.application.routes.draw do
  
  resources :periods
  get "herramientas/cambiar_periodo/:id/" => "periods#edit", :as => "cambiar_periodo"
  get "herramientas/crear_periodo" => "periods#new", :as => "crear_periodo_actual"
  get "herramientas/lista_de_periodos_creados" => "periods#index", :as => "lista_periodos"
   get "herramientas/mostrar_periodo/:id" => "periods#show", :as => "mostrar_periodo"


  get 'herramientas/graficos' => "herramientas#graficos", :as => "herramientas_graficos"

  get 'herramientas/estadisticas'=> "herramientas#estadisticas", :as => "herramientas_estadisticas"

  get 'herramientas/tablas'=> "herramientas#tablas", :as => "herramientas_tablas"

  

  

#controlador buscar
  get 'buscar/por_area' => "buscar#area", :as => "buscar_por_area"


  #controlador incio
  get 'inicio/index'

  get 'inicio/portal'=> "inicio#portal", :as => "bienvenido_portal"

 
  resources :password_resets

  
  resources :activities
     get 'academico_administrativo/menu_de_gestion' => "activities#menu_gestion_academico_administrativo", :as => "menu_academico_administrativo_1"
    get 'academico_administrativo/registrar' => "activities#new", :as => "academico_administrativo_resgistro"
    get "academico_administrativo/modificar/:id/" => "activities#edit", :as => "academico_administrativo_modificar"
    get "academico_administrativo/mostrar/:id" => "activities#show", :as => "academico_administrativo_ver"
     get "academico_administrativo/mostrar2/:id" => "activities#show2", :as => "academico_administrativo_ver2"
     post "academico_administrativo/resultados_busqueda" => "activities#index", :as => "academico_administrativo_resultados"
     
    get "academico_administrativo/buscar" => "activities#buscar_activity", :as => "academico_administrativo_buscar"
    get "academico_administrativo/buscar_menu" => "activities#buscar_menu", :as => "academico_administrativo_buscar_menu"
    get "academico_administrativo/buscar_titulo" => "activities#buscar_titulo_activity", :as => "academico_administrativo_buscar_titulo"
    get "academico_administrativo/buscar_fechas" => "activities#buscar_fechas_activity", :as => "academico_administrativo_buscar_fechas"
    get "academico_administrativo/buscar_investigador" => "activities#buscar_investigador", :as => "academico_administrativo_buscar_investigador"
    post "academico_administrativo/resultados_busqueda_prueba" => "activities#indexpdf", :as => "academico_administrativo_resultados_prueba"
      
  resources :trainings
     get 'mejoramiento_y_capacitacion/menu_de_gestion' => "trainings#menu_gestion_mejoramiento_y_capacitacion", :as => "menu_mejoramiento_y_capacitacion_1"
    get 'mejoramiento_y_capacitacion/registrar' => "trainings#new", :as => "mejoramiento_y_capacitaciona_resgistro"
    get "mejoramiento_y_capacitacion/modificar/:id/" => "trainings#edit", :as => "mejoramiento_y_capacitacion_modificar"
    get "mejoramiento_y_capacitacion/mostrar/:id" => "trainings#show", :as => "mejoramiento_y_capacitacion_ver"
    get "mejoramiento_y_capacitacion/mostrar2/:id" => "trainings#show2", :as => "mejoramiento_y_capacitacion_ver2"
    post "mejoramiento_y_capacitacion/resultados_busqueda" => "trainings#index", :as => "mejoramiento_y_capacitacion_resultados"
    
    get "mejoramiento_y_capacitacion/buscar" => "trainings#buscar_training", :as => "mejoramiento_y_capacitacion_buscar"
    get "mejoramiento_y_capacitacion/buscar_menu" => "trainings#buscar_menu", :as => "mejoramiento_y_capacitacion_buscar_menu"
    get "mejoramiento_y_capacitacion/buscar_titulo" => "trainings#buscar_titulo_training", :as => "mejoramiento_y_capacitacion_buscar_titulo"
    get "mejoramiento_y_capacitacion/buscar_fechas" => "trainings#buscar_fechas_training", :as => "mejoramiento_y_capacitacion_buscar_fechas"
    get "mejoramiento_y_capacitacion/buscar_investigador" => "trainings#buscar_investigador", :as => "mejoramiento_y_capacitacion_buscar_investigador"
      

  resources :extensions
    get 'extension/menu_de_gestion_otra' => "extensions#menu_gestion_extension", :as => "menu_extension_2"
    get 'extension/otra/registrar' => "extensions#new", :as => "extension_otra_resgistro"
    get "extension/otra/modificar/:id/" => "extensions#edit", :as => "extension_otra_modificar"
    get "extension/otra/mostrar/:id" => "extensions#show", :as => "extension_otra_ver"
    get "extension/otra/mostrar2/:id" => "extensions#show2", :as => "extension_otra_ver2"
    post "extension/otra/resultados_busqueda" => "extensions#index", :as => "extension_otra_resultados"
    
    get "extension/otra/buscar_menu" => "extensions#buscar_menu", :as => "extension_otra_buscar_menu"
    get "extension/otra/buscar" => "extensions#buscar_extension", :as => "extension_otra_buscar"
    get "extension/otra/buscar_titulo" => "extensions#buscar_titulo_extension", :as => "extension_otra_buscar_titulo"
    get "extension/otra/buscar_fechas" => "extensions#buscar_fechas_extension", :as => "extension_otra_buscar_fechas"
    get "extension/otra/buscar_investigador" => "extensions#buscar_investigador", :as => "extension_otra_buscar_investigador"

     get "extension/otra/tabla_extension_otra" => "extensions#tabla_extension_otra", :as => "herramientas_tabla_extension_otra"
      
  resources :coferences
   get 'extension/menu_gestion_conferencia_o_ponencias' => "coferences#menu_gestion_extension_conferencia_o_ponencia", :as => "menu_extension_1"
    get 'extension/conferencia_o_ponencia/registrar' => "coferences#new", :as => "extension_conferencia_o_ponencia_resgistro"
    get "extension/conferencia_o_ponencia/modificar/:id/" => "coferences#edit", :as => "extension_conferencia_o_ponencia_modificar"
    get "extension/conferencia_o_ponencia/mostrar/:id" => "coferences#show", :as => "extension_conferencia_o_ponencia_ver"
    get "extension/conferencia_o_ponencia/mostrar2/:id" => "coferences#show2", :as => "extension_conferencia_o_ponencia_ver2"

    get "extension/conferencia_o_ponencia/buscar_menu" => "coferences#buscar_menu", :as => "extension_conferencia_o_ponencia_buscar_menu"
    get "extension/conferencia_o_ponencia/buscar" => "coferences#buscar_coference", :as => "extension_conferencia_o_ponencia_buscar"
    get "extension/conferencia_o_ponencia/buscar_titulo" => "coferences#buscar_titulo_coference", :as => "extension_conferencia_o_ponencia_buscar_titulo"
    get "extension/conferencia_o_ponencia/buscar_fechas" => "coferences#buscar_fechas_coference", :as => "extension_conferencia_o_ponencia_buscar_fechas"
    get "extension/conferencia_o_ponencia/buscar_investigador" => "coferences#buscar_investigador", :as => "extension_conferencia_o_ponencia_buscar_investigador"
      
    post "extension/conferencia_o_ponencia/resultados_busqueda" => "coferences#index", :as => "extension_conferencia_o_ponencia_resultados"

  resources :teachings
    get 'docencia/menu_de_gestion_otra' => "teachings#menu_gestion_docencia", :as => "menu_docencia_4"
    get 'docencia/otra/registrar' => "teachings#new", :as => "docencia_otra_resgistro"
    get "docencia/otra/modificar/:id/" => "teachings#edit", :as => "docencia_otra_modificar"
    get "docencia/otra/mostrar/:id" => "teachings#show", :as => "docencia_otra_ver"
    get "docencia/otra/mostrar2/:id" => "teachings#show2", :as => "docencia_otra_ver2"
    
    post "docencia/otra/resultados_busqueda" => "teachings#index", :as => "docencia_otra__resultados"
    get "docencia/otra/buscar_menu" => "teachings#buscar_menu", :as => "docencia_otra_buscar_menu"
    get "docencia/otra/buscar" => "teachings#buscar_teaching", :as => "docencia_otra_buscar"
    get "docencia/otra/buscar_titulo" => "teachings#buscar_titulo_teaching", :as => "docencia_otra_buscar_titulo"
    get "docencia/otra/buscar_fechas" => "teachings#buscar_fechas_teaching", :as => "docencia_otra_buscar_fechas"
    get "docencia/otra/buscar_investigador" => "teachings#buscar_investigador", :as => "docencia_otra_buscar_investigador"
      

  resources :works
    get 'docencia/menu_de_gestion_trabajos_de_grado' => "works#menu_gestion_docencia_trabajos", :as => "menu_docencia_3"
    get 'docencia/trabajos/registrar' => "works#new", :as => "docencia_trabajos_resgistro"
    get "docencia/trabajos/modificar/:id/" => "works#edit", :as => "docencia_trabajos_modificar"
    get "docencia/trabajos/mostrar/:id" => "works#show", :as => "docencia_trabajos_ver"
    get "docencia/trabajos/mostrar2/:id" => "works#show2", :as => "docencia_trabajos_ver2"
    
    post "docencia/trabajos/resultados_busqueda" => "works#index", :as => "docencia_trabajos_resultados"
    get "docencia/trabajos/buscar_menu" => "works#buscar_menu", :as => "docencia_trabajos_buscar_menu"
    get "docencia/trabajos/buscar" => "works#buscar_work", :as => "docencia_trabajos_buscar"
    get "docencia/trabajos/buscar_titulo" => "works#buscar_titulo_work", :as => "docencia_trabajos_buscar_titulo"
    get "docencia/trabajos/buscar_fechas" => "works#buscar_fechas_work", :as => "docencia_trabajos_buscar_fechas"
    get "docencia/trabajos/buscar_investigador" => "works#buscar_investigador", :as => "docencia_trabajos_buscar_investigador"
      
  resources :tutorings
  get 'docencia/menu_de_gestion_tutorias' => "tutorings#menu_gestion_docencia_tutoria", :as => "menu_docencia_2"
    get 'docencia/tutoria/registrar' => "tutorings#new", :as => "docencia_tutoria_resgistro"
    get "docencia/tutoria/modificar/:id/" => "tutorings#edit", :as => "docencia_tutoria_modificar"
    get "docencia/tutoria/mostrar/:id" => "tutorings#show", :as => "docencia_tutoria_ver"
    get "docencia/tutoria/mostrar2/:id" => "tutorings#show2", :as => "docencia_tutoria_ver2"
    
    post "docencia/tutoria/resultados_busqueda" => "tutorings#index", :as => "docencia_tutoria_resultados"
    get "docencia/tutoria/buscar_menu" => "tutorings#buscar_menu", :as => "docencia_tutoria_buscar_menu"
    get "docencia/tutoria/buscar" => "tutorings#buscar_tutoring", :as => "docencia_tutoria_buscar"
    get "docencia/tutoria/buscar_titulo" => "tutorings#buscar_titulo_tutoring", :as => "docencia_tutoria_buscar_titulo"
    get "docencia/tutoria/buscar_fechas" => "tutorings#buscar_fechas_tutoring", :as => "docencia_tutoria_buscar_fechas"
    get "docencia/tutoria/buscar_investigador" => "tutorings#buscar_investigador", :as => "docencia_tutoria_buscar_investigador"
      
  resources :subjects
    get 'docencia/menu_de_gestion_dictados_asignatura' => "subjects#menu_gestion_docencia_asignatura", :as => "menu_docencia_1"
    get 'docencia/asignatura/registrar' => "subjects#new", :as => "docencia_asignatura_resgistro"
    get "docencia/asignatura/modificar/:id/" => "subjects#edit", :as => "docencia_asignatura_modificar"
    get "docencia/asignatura/mostrar/:id" => "subjects#show", :as => "docencia_asignatura_ver"
    get "docencia/asignatura/mostrar2/:id" => "subjects#show2", :as => "docencia_asignatura_ver2"
    
    post "docencia/asignatura/resultados_busqueda" => "subjects#index", :as => "docencia_asignatura_resultados"
    get "docencia/asignatura/buscar_menu" => "subjects#buscar_menu", :as => "docencia_asignatura_buscar_menu"
    get "docencia/asignatura/buscar" => "subjects#buscar_subject", :as => "docencia_asignatura_buscar"
    get "docencia/asignatura/buscar_titulo" => "subjects#buscar_titulo_subject", :as => "docencia_asignatura_buscar_titulo"
    get "docencia/asignatura/buscar_fechas" => "subjects#buscar_fechas_subject", :as => "docencia_asignatura_buscar_fechas"
    get "docencia/asignatura/buscar_investigador" => "subjects#buscar_investigador", :as => "docencia_asignatura_buscar_investigador"

     get "docencia/asignatura/tabla_oferta_de_asignatura_de_pregrado" => "subjects#tabla_oferta_de_asignatura_de_pregrado", :as => "herramientas_tabla_oferta_de_asignatura_de_pregrado"
      get "docencia/asignatura/tabla_oferta_de_asignatura_de_postgrado" => "subjects#tabla_oferta_de_asignatura_de_postgrado", :as => "herramientas_tabla_oferta_de_asignatura_de_postgrado"

      get "docencia/asignatura/tabla_resumen_totalizador_de_asignaturas_de_postgrado_pregrado" => "subjects#tabla_resumen_totalizador_de_asignaturas_de_postgrado_pregrado", :as => "herramientas_tabla_resumen_totalizador_de_asignaturas_de_postgrado_pregrado"

  resources :researches
    get 'investigacion/menu_de_gestion_otra' => "researches#menu_gestion_investigacion", :as => "menu_investigacion_3"
    get 'investigacion/otra/registrar' => "researches#new", :as => "investigacion_otra_resgistro"
    get "investigacion/otra/modificar/:id/" => "researches#edit", :as => "investigacion_otra_modificar"
    get "investigacion/otra/mostrar/:id" => "researches#show", :as => "investigacion_otra_ver"
    get "investigacion/otra/mostrar2/:id" => "researches#show2", :as => "investigacion_otra_ver2"
    
    post "investigacion/otra/resultados_busqueda" => "researches#index", :as => "investigacion_otra_resultados"
    get "investigacion/otra/resultados_busqueda" => "researches#index", :as => "investigacion_otra_resultados2"
    get "investigacion/otra/buscar_menu" => "researches#buscar_menu", :as => "investigacion_otra_buscar_menu"
    get "investigacion/otra/buscar" => "researches#buscar_research", :as => "investigacion_otra_buscar"
    get "investigacion/otra/buscar_titulo" => "researches#buscar_titulo_research", :as => "investigacion_otra_buscar_titulo"
    get "investigacion/otra/buscar_fechas" => "researches#buscar_fechas_research", :as => "investigacion_otra_buscar_fechas"
    get "investigacion/otra/buscar_investigador" => "researches#buscar_investigador", :as => "investigacion_otra_buscar_investigador"
      
  resources :publications   
 get 'investigacion/menu_de_gestion_publicacion' => "publications#menu_gestion_investigacion_publicacion", :as => "menu_investigacion_2"
  get 'investigacion/publicacion/registrar' => "publications#new", :as => "investigacion_publicacion_resgistro"
  get "investigacion/publicacion/modificar/:id/" => "publications#edit", :as => "investigacion_publicacion_modificar"
  get "investigacion/publicacion/mostrar/:id" => "publications#show", :as => "investigacion_publicacion_ver"
  get "investigacion/publicacion/mostrar2/:id" => "publications#show2", :as => "investigacion_publicacion_ver2"
  
  post "investigacion/publicacion/resultados_busqueda" => "publications#index", :as => "investigacion_publicacion_resultados"
  get "investigacion/publicacion/buscar_menu" => "publications#buscar_menu", :as => "investigacion_publicacion_buscar_menu"
  get "investigacion/publicacion/buscar" => "publications#buscar_publication", :as => "investigacion_publicacion_buscar"
  get "investigacion/publicacion/buscar_titulo" => "publications#buscar_titulo_publication", :as => "investigacion_publicacion_buscar_titulo"
  get "investigacion/publicacion/buscar_fechas" => "publications#buscar_fechas_publication", :as => "investigacion_publicacion_buscar_fechas"
  get "investigacion/publicacion/buscar_investigador" => "publications#buscar_investigador", :as => "investigacion_publicacion_buscar_investigador"
      
  resources :proyects
  get 'investigacion/menu_de_gestion_proyecto' => "proyects#menu_gestion_investigacion_proyecto", :as => "menu_investigacion_1"
  get 'investigacion/proyecto/registrar' => "proyects#new", :as => "investigacion_proyecto_resgistro"
  get "investigacion/proyecto/modificar/:id/" => "proyects#edit", :as => "investigacion_proyecto_modificar"
  get "investigacion/proyecto/mostrar/:id" => "proyects#show", :as => "investigacion_proyecto_ver"
  get "investigacion/proyecto/mostrar2/:id" => "proyects#show2", :as => "investigacion_proyecto_ver2"
  
  post "investigacion/proyecto/resultados_busqueda" => "proyects#index", :as => "investigacion_proyecto_resultados"

  get "investigacion/proyecto/buscar_menu" => "proyects#buscar_menu", :as => "investigacion_proyecto_buscar_menu"
  get "investigacion/proyecto/buscar" => "proyects#buscar_proyect", :as => "investigacion_proyecto_buscar"
  get "investigacion/proyecto/buscar_titulo" => "proyects#buscar_titulo_proyect", :as => "investigacion_proyecto_buscar_titulo"
  get "investigacion/proyecto/buscar_fechas" => "proyects#buscar_fechas_proyect", :as => "investigacion_proyecto_buscar_fechas"
  get "investigacion/proyecto/buscar_investigador" => "proyects#buscar_investigador", :as => "investigacion_proyecto_buscar_investigador"
  get 'proyectos/tabla_resumen_totalizador_de_investigaciones'=> "proyects#tabla_resumen_totalizador_de_investigaciones", :as => "herramientas_tabla_resumen_totalizador_de_investigaciones"

  get 'proyectos/tabla_investigaciones_de_grupo_en_espera'=> "proyects#tabla_investigaciones_de_grupo_en_espera", :as => "herramientas_tabla_investigaciones_de_grupo_en_espera"

  get 'proyectos/tabla_investigaciones_individual_en_espera'=> "proyects#tabla_investigaciones_individual_en_espera", :as => "herramientas_tabla_investigaciones_individual_en_espera"

  get 'proyectos/tabla_investigaciones_de_grupo_culminados'=> "proyects#tabla_investigaciones_de_grupo_culminados", :as => "herramientas_tabla_investigaciones_de_grupo_culminados"

  get 'proyectos/tabla_investigaciones_individual_culminados'=> "proyects#tabla_investigaciones_individual_culminados", :as => "herramientas_tabla_investigaciones_individual_culminados"

  get 'proyectos/tabla_investigaciones_de_grupo'=> "proyects#tabla_investigaciones_de_grupo", :as => "herramientas_tabla_investigaciones_de_grupo"

  get 'proyectos/tabla_investigaciones_individual'=> "proyects#tabla_investigaciones_individual", :as => "herramientas_tabla_investigaciones_individual"
      

  resources :users
    
    get "gestion_de_usuarios/registro" => "users#new", :as => "registro"
    get "gestion_de_usuarios/buscar" => "users#buscar_usuario", :as => "buscar_usuario"
    get "gestion_de_usuarios/:id/modificar" => "users#edit", :as => "modificar_usuario"

     get "gestion_de_usuarios/perfil/:id" => "users#show", :as => "perfil"
     post "gestion_de_usuarios/perfil" => "users#show", :as => "perfil_usuario"

 get "gestion_de_usuarios/:id/modificar_clave" => "users#edit2", :as => "modificar_clave_usuario"
 
     get "gestion_de_usuarios/:id/modificar_clave_de_usuario" => "users#seleccionar_usuario", :as => "administrar_seleccionar_usuario"

      put "gestion_de_usuarios/cambiar_clave" => "users#cambiar_clave", :as => "administrar_cambiar_clave"
      # put "gestion_de_usuarios/cambiar_clave" => "users#cambiar_clave", :as => "administrar_cambiar_clave"

     get "gestion_de_usuarios/lista_usuarios" => "users#index", :as => "usuarios_listar"
     get 'gestion_de_usuarios/tabla_jefe_de_departamento_del_idec'=> "users#tabla_jefe_de_departamento_del_idec", :as => "herramientas_tabla_jefe_de_departamento_del_idec"

     get 'gestion_de_usuarios/tabla_profesores ordinarios'=> "users#tabla_profesores_ordinarios", :as => "herramientas_tabla_profesores_ordinarios"

    
  resources :sessions
      get "logout" => "sessions#destroy", :as => "logout"
      get "autenticacion" => "sessions#new", :as => "autenticacion"
      post "opor" => "sessions#create", :as => "portal"
      get 'sessions/new'

   resources :inicio

      get "IDEC" => "inicio#index", :as => "IDEC"
      


  root :to => "inicio#index" 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
