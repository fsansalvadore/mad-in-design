# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_30_112134) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "article_content_modules", force: :cascade do |t|
    t.text "rich_text"
    t.string "image"
    t.string "image_description"
    t.integer "video_provider"
    t.string "video_url"
    t.boolean "visible"
    t.integer "position"
    t.bigint "workshop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workshop_id"], name: "index_article_content_modules_on_workshop_id"
  end

  create_table "collaborators", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.string "link_alt_text"
    t.text "description"
    t.string "photo"
    t.integer "position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "committees", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.text "description"
    t.string "photo"
    t.integer "position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "home_pages", force: :cascade do |t|
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.boolean "banner_visibility"
    t.string "banner_image"
    t.string "main_title_one"
    t.string "main_title_two"
    t.string "subtitle"
    t.boolean "sticky_box_visibility"
    t.string "sticky_box_text"
    t.string "sticky_box_link_url"
    t.string "sticky_box_cta_text"
    t.string "chi_siamo_box_label"
    t.text "chi_siamo_box_text"
    t.string "chi_siamo_box_cta"
    t.string "people_box_label"
    t.string "people_box_text"
    t.string "people_box_cta"
    t.string "contacts_box_label"
    t.string "contacts_box_text"
    t.string "contacts_box_cta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "partners", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.integer "position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "project_content_sections", force: :cascade do |t|
    t.text "rich_text"
    t.string "image"
    t.string "image_width"
    t.integer "video_provider"
    t.string "video_url"
    t.integer "position"
    t.boolean "published", default: true
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "typology", default: 0
    t.index ["project_id"], name: "index_project_content_sections_on_project_id"
  end

  create_table "project_leaders", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.text "description"
    t.string "photo"
    t.integer "year"
    t.integer "position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.date "start_date"
    t.string "cover"
    t.string "highlight_image"
    t.boolean "published"
    t.boolean "featured"
    t.integer "priority"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "site_global_settings", force: :cascade do |t|
    t.string "site_name"
    t.integer "maintenance_mode"
    t.text "maintenance_message"
    t.integer "language"
    t.string "favicon"
    t.string "google_verification_code"
    t.integer "background_decoration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "socials", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "logo"
    t.bigint "site_global_settings_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_global_settings_id"], name: "index_socials_on_site_global_settings_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.text "description"
    t.string "photo"
    t.integer "position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_outcome_content_modules", force: :cascade do |t|
    t.text "rich_text"
    t.string "image"
    t.string "image_description"
    t.integer "video_provider"
    t.string "video_url"
    t.boolean "visible"
    t.integer "position"
    t.bigint "team_outcome_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_outcome_id"], name: "index_team_outcome_content_modules_on_team_outcome_id"
  end

  create_table "team_outcomes", force: :cascade do |t|
    t.string "title"
    t.text "subtitle"
    t.string "cover"
    t.integer "priority"
    t.boolean "published"
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.bigint "workshop_team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "position"
    t.index ["slug"], name: "index_team_outcomes_on_slug", unique: true
    t.index ["workshop_team_id"], name: "index_team_outcomes_on_workshop_team_id"
  end

  create_table "tecnical_sponsors", force: :cascade do |t|
    t.string "logo"
    t.string "alt_text"
    t.integer "position"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workshop_carousel_images", force: :cascade do |t|
    t.string "image"
    t.bigint "workshop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workshop_id"], name: "index_workshop_carousel_images_on_workshop_id"
  end

  create_table "workshop_outcome_images", force: :cascade do |t|
    t.bigint "workshop_outcome_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["workshop_outcome_id"], name: "index_workshop_outcome_images_on_workshop_outcome_id"
  end

  create_table "workshop_outcomes", force: :cascade do |t|
    t.bigint "workshop_id", null: false
    t.string "title"
    t.string "sottotitolo"
    t.text "content"
    t.boolean "visible", default: true
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_1"
    t.string "image_2"
    t.string "image_3"
    t.string "image_4"
    t.string "image_5"
    t.string "outcome_images"
    t.index ["workshop_id"], name: "index_workshop_outcomes_on_workshop_id"
  end

  create_table "workshop_teams", force: :cascade do |t|
    t.string "title"
    t.string "project_leader"
    t.string "image"
    t.bigint "workshop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.string "slug"
    t.index ["slug"], name: "index_workshop_teams_on_slug", unique: true
    t.index ["workshop_id"], name: "index_workshop_teams_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.integer "typology", default: 0
    t.string "title"
    t.text "subtitle"
    t.date "start_date"
    t.date "end_date"
    t.string "cover"
    t.string "big_image"
    t.text "body_copy"
    t.integer "lang"
    t.integer "priority"
    t.boolean "published", default: false
    t.datetime "publish_date"
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "outcome_1_title"
    t.string "outcome_1_subtitle"
    t.text "outcome_1_content"
    t.boolean "outcome_1_display"
    t.string "outcome_1_img_1"
    t.string "outcome_1_img_2"
    t.string "outcome_1_img_3"
    t.string "outcome_1_img_4"
    t.string "outcome_1_img_5"
    t.string "outcome_2_title"
    t.string "outcome_2_subtitle"
    t.text "outcome_2_content"
    t.boolean "outcome_2_display"
    t.string "outcome_2_img_1"
    t.string "outcome_2_img_2"
    t.string "outcome_2_img_3"
    t.string "outcome_2_img_4"
    t.string "outcome_2_img_5"
    t.string "outcome_3_title"
    t.string "outcome_3_subtitle"
    t.text "outcome_3_content"
    t.boolean "outcome_3_display"
    t.string "outcome_3_img_1"
    t.string "outcome_3_img_2"
    t.string "outcome_3_img_3"
    t.string "outcome_3_img_4"
    t.string "outcome_3_img_5"
    t.string "outcome_4_title"
    t.string "outcome_4_subtitle"
    t.text "outcome_4_content"
    t.boolean "outcome_4_display"
    t.string "outcome_4_img_1"
    t.string "outcome_4_img_2"
    t.string "outcome_4_img_3"
    t.string "outcome_4_img_4"
    t.string "outcome_4_img_5"
    t.string "outcome_5_title"
    t.string "outcome_5_subtitle"
    t.text "outcome_5_content"
    t.boolean "outcome_5_display"
    t.string "outcome_5_img_1"
    t.string "outcome_5_img_2"
    t.string "outcome_5_img_3"
    t.string "outcome_5_img_4"
    t.string "outcome_5_img_5"
    t.string "outcome_6_title"
    t.string "outcome_6_subtitle"
    t.text "outcome_6_content"
    t.boolean "outcome_6_display"
    t.string "outcome_6_img_1"
    t.string "outcome_6_img_2"
    t.string "outcome_6_img_3"
    t.string "outcome_6_img_4"
    t.string "outcome_6_img_5"
    t.index ["slug"], name: "index_workshops_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "article_content_modules", "workshops"
  add_foreign_key "project_content_sections", "projects"
  add_foreign_key "socials", "site_global_settings", column: "site_global_settings_id"
  add_foreign_key "team_outcome_content_modules", "team_outcomes"
  add_foreign_key "team_outcomes", "workshop_teams"
  add_foreign_key "workshop_carousel_images", "workshops"
  add_foreign_key "workshop_outcome_images", "workshop_outcomes"
  add_foreign_key "workshop_outcomes", "workshops"
  add_foreign_key "workshop_teams", "workshops"
end
