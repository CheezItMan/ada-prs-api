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

ActiveRecord::Schema.define(version: 2019_01_15_002407) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classrooms", force: :cascade do |t|
    t.integer "cohort_number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms_repos", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "repo_id", null: false
  end

  create_table "classrooms_users", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "user_id", null: false
    t.index ["classroom_id", "user_id"], name: "index_classrooms_users_on_classroom_id_and_user_id"
    t.index ["user_id", "classroom_id"], name: "index_classrooms_users_on_user_id_and_classroom_id"
  end

  create_table "repos", force: :cascade do |t|
    t.string "repo_url"
    t.boolean "individual"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_submissions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submission_id"], name: "index_student_submissions_on_submission_id"
    t.index ["user_id"], name: "index_student_submissions_on_user_id"
  end

# Could not dump table "submissions" because of following StandardError
#   Unknown type 'submission_grade' for column 'grade'

  create_table "users", force: :cascade do |t|
    t.string "login"
    t.string "name"
    t.string "email"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "uid"
    t.string "current_access_token"
  end

  add_foreign_key "student_submissions", "submissions"
  add_foreign_key "student_submissions", "users"
  add_foreign_key "submissions", "repos"
end
