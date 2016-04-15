# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160413154013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["ano_periodo"], name: "index_activities_on_ano_periodo", using: :btree
  add_index "activities", ["tipo"], name: "index_activities_on_tipo", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "coference_users", force: :cascade do |t|
    t.integer  "coference_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "coference_users", ["coference_id"], name: "index_coference_users_on_coference_id", using: :btree
  add_index "coference_users", ["user_id"], name: "index_coference_users_on_user_id", using: :btree

  create_table "coferences", force: :cascade do |t|
    t.string   "tipo",        null: false
    t.string   "titulo",      null: false
    t.string   "evento",      null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "coferences", ["ano_periodo"], name: "index_coferences_on_ano_periodo", using: :btree
  add_index "coferences", ["creador"], name: "index_coferences_on_creador", using: :btree
  add_index "coferences", ["evento"], name: "index_coferences_on_evento", using: :btree
  add_index "coferences", ["tipo"], name: "index_coferences_on_tipo", using: :btree

  create_table "extension_users", force: :cascade do |t|
    t.integer  "extension_id"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "extension_users", ["extension_id"], name: "index_extension_users_on_extension_id", using: :btree
  add_index "extension_users", ["user_id"], name: "index_extension_users_on_user_id", using: :btree

  create_table "extensions", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "extensions", ["ano_periodo"], name: "index_extensions_on_ano_periodo", using: :btree
  add_index "extensions", ["creador"], name: "index_extensions_on_creador", using: :btree
  add_index "extensions", ["tipo"], name: "index_extensions_on_tipo", using: :btree

  create_table "periods", primary_key: "ano_periodo", force: :cascade do |t|
    t.string   "estatus",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "periods", ["ano_periodo"], name: "index_periods_on_ano_periodo", unique: true, using: :btree

  create_table "proyect_users", force: :cascade do |t|
    t.integer  "proyect_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "proyect_users", ["proyect_id"], name: "index_proyect_users_on_proyect_id", using: :btree
  add_index "proyect_users", ["user_id"], name: "index_proyect_users_on_user_id", using: :btree

  create_table "proyects", force: :cascade do |t|
    t.string   "titulo",                   null: false
    t.string   "estatus",                  null: false
    t.string   "ente_financista",          null: false
    t.float    "monto"
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",                  null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo",              null: false
    t.integer  "creador",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "integrantes"
    t.string   "investigador_responsable"
    t.string   "co_investigador"
    t.string   "grupo_o_individual"
  end

  add_index "proyects", ["ano_periodo"], name: "index_proyects_on_ano_periodo", using: :btree
  add_index "proyects", ["creador"], name: "index_proyects_on_creador", using: :btree
  add_index "proyects", ["estatus"], name: "index_proyects_on_estatus", using: :btree

  create_table "publication_users", force: :cascade do |t|
    t.integer  "publication_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "publication_users", ["publication_id"], name: "index_publication_users_on_publication_id", using: :btree
  add_index "publication_users", ["user_id"], name: "index_publication_users_on_user_id", using: :btree

  create_table "publications", force: :cascade do |t|
    t.string   "titulo",            null: false
    t.string   "revista_editorial", null: false
    t.string   "arbitr_no_arbitr"
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",           null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo",       null: false
    t.integer  "creador",           null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "publications", ["ano_periodo"], name: "index_publications_on_ano_periodo", using: :btree
  add_index "publications", ["creador"], name: "index_publications_on_creador", using: :btree
  add_index "publications", ["revista_editorial"], name: "index_publications_on_revista_editorial", using: :btree

  create_table "research_users", force: :cascade do |t|
    t.integer  "research_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "research_users", ["research_id"], name: "index_research_users_on_research_id", using: :btree
  add_index "research_users", ["user_id"], name: "index_research_users_on_user_id", using: :btree

  create_table "researches", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "researches", ["ano_periodo"], name: "index_researches_on_ano_periodo", using: :btree
  add_index "researches", ["creador"], name: "index_researches_on_creador", using: :btree
  add_index "researches", ["tipo"], name: "index_researches_on_tipo", using: :btree

  create_table "subject_users", force: :cascade do |t|
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subject_users", ["subject_id"], name: "index_subject_users_on_subject_id", using: :btree
  add_index "subject_users", ["user_id"], name: "index_subject_users_on_user_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subjects", ["ano_periodo"], name: "index_subjects_on_ano_periodo", using: :btree
  add_index "subjects", ["creador"], name: "index_subjects_on_creador", using: :btree
  add_index "subjects", ["tipo"], name: "index_subjects_on_tipo", using: :btree

  create_table "teaching_users", force: :cascade do |t|
    t.integer  "teaching_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teaching_users", ["teaching_id"], name: "index_teaching_users_on_teaching_id", using: :btree
  add_index "teaching_users", ["user_id"], name: "index_teaching_users_on_user_id", using: :btree

  create_table "teachings", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "teachings", ["ano_periodo"], name: "index_teachings_on_ano_periodo", using: :btree
  add_index "teachings", ["creador"], name: "index_teachings_on_creador", using: :btree
  add_index "teachings", ["tipo"], name: "index_teachings_on_tipo", using: :btree

  create_table "training_users", force: :cascade do |t|
    t.integer  "training_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "training_users", ["training_id"], name: "index_training_users_on_training_id", using: :btree
  add_index "training_users", ["user_id"], name: "index_training_users_on_user_id", using: :btree

  create_table "trainings", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "trainings", ["ano_periodo"], name: "index_trainings_on_ano_periodo", using: :btree
  add_index "trainings", ["creador"], name: "index_trainings_on_creador", using: :btree
  add_index "trainings", ["tipo"], name: "index_trainings_on_tipo", using: :btree

  create_table "tutoring_users", force: :cascade do |t|
    t.integer  "tutoring_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tutoring_users", ["tutoring_id"], name: "index_tutoring_users_on_tutoring_id", using: :btree
  add_index "tutoring_users", ["user_id"], name: "index_tutoring_users_on_user_id", using: :btree

  create_table "tutorings", force: :cascade do |t|
    t.string   "nombre",      null: false
    t.string   "tipo",        null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tutorings", ["ano_periodo"], name: "index_tutorings_on_ano_periodo", using: :btree
  add_index "tutorings", ["creador"], name: "index_tutorings_on_creador", using: :btree
  add_index "tutorings", ["tipo"], name: "index_tutorings_on_tipo", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "nombre1",                         null: false
    t.string   "nombre2"
    t.string   "apellido1",                       null: false
    t.string   "apellido2"
    t.text     "direccion"
    t.string   "password"
    t.string   "tlf"
    t.string   "rol",                             null: false
    t.string   "dedicacion"
    t.string   "cargo",                           null: false
    t.string   "area"
    t.string   "categoria_actual"
    t.integer  "anos_serv"
    t.string   "adscrito"
    t.date     "fecha_ult_ascenso"
    t.string   "grado_academico"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "estatus_user"
    t.date     "ultima_conexion"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["id"], name: "index_users_on_id", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  create_table "work_users", force: :cascade do |t|
    t.integer  "work_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "work_users", ["user_id"], name: "index_work_users_on_user_id", using: :btree
  add_index "work_users", ["work_id"], name: "index_work_users_on_work_id", using: :btree

  create_table "works", force: :cascade do |t|
    t.string   "tipo",        null: false
    t.string   "titulo",      null: false
    t.text     "autores",     null: false
    t.text     "descripcion"
    t.integer  "horas"
    t.date     "fecha_i",     null: false
    t.date     "fecha_f"
    t.integer  "ano_periodo", null: false
    t.integer  "creador",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "works", ["ano_periodo"], name: "index_works_on_ano_periodo", using: :btree
  add_index "works", ["autores"], name: "index_works_on_autores", using: :btree
  add_index "works", ["creador"], name: "index_works_on_creador", using: :btree
  add_index "works", ["tipo"], name: "index_works_on_tipo", using: :btree

  add_foreign_key "activities", "users"
end
