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

ActiveRecord::Schema.define(version: 2020_06_24_133721) do

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

  create_table "people", force: :cascade do |t|
    t.bigint "people_category_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.text "description"
    t.boolean "published", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["people_category_id"], name: "index_people_on_people_category_id"
  end

  create_table "people_categories", force: :cascade do |t|
    t.string "title"
    t.boolean "published", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "start_date"
    t.string "cover"
    t.string "big_image"
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

  create_table "special_workshop_days", force: :cascade do |t|
    t.string "title"
    t.text "subtitle"
    t.string "cover"
    t.integer "priority"
    t.boolean "published", default: true
    t.string "meta_title"
    t.string "meta_description"
    t.string "meta_keywords"
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

  create_table "workshop_day_content_modules", force: :cascade do |t|
    t.text "rich_text"
    t.string "image"
    t.string "image_description"
    t.integer "video_provider"
    t.string "video_url"
    t.boolean "visible"
    t.integer "position"
    t.bigint "special_workshop_day_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["special_workshop_day_id"], name: "index_workshop_day_content_modules_on_special_workshop_day_id"
  end

  create_table "workshop_outcome_images", force: :cascade do |t|
    t.bigint "workshop_outcome_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["workshop_id"], name: "index_workshop_outcomes_on_workshop_id"
  end

  create_table "workshops", force: :cascade do |t|
    t.integer "type", default: 0
    t.string "title"
    t.text "subtitle"
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
    t.datetime "start_date"
    t.datetime "end_date"
    t.index ["slug"], name: "index_workshops_on_slug", unique: true
  end

  add_foreign_key "article_content_modules", "workshops"
  add_foreign_key "people", "people_categories"
  add_foreign_key "socials", "site_global_settings", column: "site_global_settings_id"
  add_foreign_key "workshop_carousel_images", "workshops"
  add_foreign_key "workshop_day_content_modules", "special_workshop_days"
  add_foreign_key "workshop_outcome_images", "workshop_outcomes"
  add_foreign_key "workshop_outcomes", "workshops"
end
