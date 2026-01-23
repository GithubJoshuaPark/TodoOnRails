# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

## 버전 정보: 가장 마지막에 실행된 마이그레이션 파일의 타임스탬프(2026_01_22_065726)
ActiveRecord::Schema[8.1].define(version: 2026_01_22_065726) do
  create_table "todos", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.boolean "completed", default: false
    t.datetime "created_at", null: false
    t.text "description"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false # t.reference :user에 의해 생성된 컬럼
    t.index ["user_id"], name: "index_todos_on_user_id" # user_id 컬럼에 대한 생성된 인덱스
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_uca1400_ai_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "login_id"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.index ["login_id"], name: "index_users_on_login_id", unique: true # migrate에서 정의한 unique 인덱스
  end

  # 외래키 제약 조건 명시 (todos 테이블의 user_id 컬럼이 users 테이블의 id 컬럼을 참조)
  add_foreign_key "todos", "users"
end
